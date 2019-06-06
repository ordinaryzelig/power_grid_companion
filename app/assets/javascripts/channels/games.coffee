# Public channel that all Players in a Game can subscribe to.
window.subscribe_game = (game_id) ->

  App.games = App.cable.subscriptions.create {
    channel: "GamesChannel"
    id: game_id
  },

    connected: ->
      console.log "subscribed to game #{game_id}"

    received: (data) ->
      @[data.action](data)

  #########
  # Private

    status: (data) ->
      for player in data.game.players
        @update_player(player)

    update_player: (player) ->
      @update_turn_order_player player
      @update_playet_mat player

    update_turn_order_player: (player) ->
      turn_order = $("#player_#{player.id}")
      turn_order.setData(player)

    update_playet_mat: (player) ->
      playet_mat = $("#player_mat_#{player.id}")
      for attr in ['cities', 'power_capacity']
        playet_mat.magic_update(attr, player[attr])

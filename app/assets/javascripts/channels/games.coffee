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
      turn_order = $("#player_#{player.id}")
      turn_order.setData(player)
      for attr in ['cities', 'power_capacity']
        turn_order.magic_update(attr, player[attr])

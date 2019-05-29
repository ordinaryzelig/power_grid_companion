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

    player_online: (data) ->
      console.log "Player #{data.player_id} is online."

    player_offline: (data) ->
      console.log "Player #{data.player_id} is offline."

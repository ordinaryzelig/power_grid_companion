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

    player_online_status_change: (data) ->
      console.log "Player #{data.player_id} status: #{data.status}."
      $("#player_#{data.player_id}").toggleClass('online', data.status == 'online')

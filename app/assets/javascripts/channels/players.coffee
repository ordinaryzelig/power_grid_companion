window.subscribe_player = (player_id) ->

  App.players = App.cable.subscriptions.create {
    channel: "PlayersChannel"
    id: player_id
  },

    connected: ->
      @online()

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      console.log data

  #########
  # Private

    online: ->
      @perform('online')

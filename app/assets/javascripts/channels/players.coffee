window.subscribe_player = (player_id) ->

  App.players = App.cable.subscriptions.create {
    channel: "PlayersChannel"
    id: player_id
  },

    connected: ->
      @online()

    received: (data) ->
      console.log data

  #########
  # Private

    online: ->
      @perform('online')

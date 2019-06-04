# Private channel per Player.
window.subscribe_player = (player_id) ->

  App.players = App.cable.subscriptions.create {
    channel: "PlayersChannel"
    id: player_id
  },

    connected: ->
      @perform('online')

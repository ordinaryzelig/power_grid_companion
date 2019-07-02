# Private channel per Player.
window.subscribe_player = (player_id) ->

  App.players = App.cable.subscriptions.create {
    channel: "PlayersChannel"
    id: player_id
  },

    connected: ->
      @perform('online')

    received: (data) ->
      console.log data
      @[data.action](data)

  #########
  # Actions

    your_turn: (data) ->
      $(".game_phase_#{data.phase} .your_turn_false").show()

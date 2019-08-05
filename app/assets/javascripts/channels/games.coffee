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
  # Actions

    status: (data) ->
      for player in data.game.players
        @update_player(player)
      @set_current_player(data.game.phase_player_ids[0])

    log: (data) ->
      html =
        """
          <div class="toast" id="#{data.message_id}">
            <div class="toast-body p-1">
              #{data.message}
            </div>
          </div>
        """
      $('#toasts').append(html)
      (new Toast($("##{data.message_id}")[0], delay: 3000)).show()

    replace: (data) ->
      $(data.dom_id).replaceWith(data.html)

  #########
  # Private

    update_player: (player) ->
      @update_player_div player
      @update_playet_mat player
      @update_join_table player

    update_player_div: (player) ->
      player_div = $("#player_#{player.id}")
      player_div.setData(player)

    update_join_table: (player) ->
      $("#join_game #player_#{player.id} input[type=submit]").attr('disabled', player.online)

    update_playet_mat: (player) ->
      playet_mat = $("#player_mat_#{player.id}")
      for attr in ['cities', 'power_capacity']
        playet_mat.magic_update(attr, player[attr])

    set_current_player: (player_id) ->
      $('.turn_order .player').removeClass('active')
      $("#player_#{player_id}").addClass('active')

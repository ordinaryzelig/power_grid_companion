$(document).on 'turbolinks:load', ->

  collapsibles = $('#game_nav_panes > .collapse')

  collapsibles.on 'show.bs.collapse', (event) ->
    data_target = "##{event.target.id}"
    toggle_game_nav_link_active data_target, true

  collapsibles.on 'hide.bs.collapse', (event) ->
    data_target = "##{event.target.id}"
    toggle_game_nav_link_active data_target, false

  toggle_game_nav_link_active = (data_target, active) ->
    selector = "#game_nav .nav-link[data-target=\"#{data_target}\"]"
    nav_link = $(selector)
    nav_link.toggleClass('active', active)

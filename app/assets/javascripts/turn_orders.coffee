$(document).on 'turbolinks:load', ->

  players = $('.turn_order .player')
  players.tooltip(
    title: -> $(@).data('name')
  )
  players.click ->
    $(@).tooltip('show')

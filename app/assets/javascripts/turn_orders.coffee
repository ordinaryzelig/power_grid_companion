$(document).on 'turbolinks:load', ->

  players = $('.player')
  players.tooltip(
    title: -> $(@).data('name')
  )
  players.click ->
    $(@).tooltip('show')

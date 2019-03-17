$(document).on 'turbolinks:load', ->
  $('#turn_order').on 'click', ->
    $('#player_mats').collapse 'toggle'

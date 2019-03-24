$(document).on 'turbolinks:load', ->
  market = $('#resource_market')
  market.collapse('show')
  market.addClass('active')

  market.find('.resource_token').on 'click', ->
    token = $(@)
    token.toggleClass('selected')
    updateCounts()
    updateTotal()

  updateCounts = ->
    for kind in ['coal', 'oil', 'uranium', 'trash']
      selected = $(".resource_token.selected[data-kind=\"#{kind}\"]")
      $("#resource_purchase_#{kind}").val selected.length

  updateTotal = ->
    total = 0
    $.each $('.resource_token.selected'), ->
      total += $(@).data('cost')
    $('#new_resource_purchase #cost').html total

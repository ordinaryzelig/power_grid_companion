window.setup_auction = ->

  markets = $('#markets')
  show_markets()
  power_plants = markets.find('.actual .power_plant')

  power_plants.on 'click', ->
    power_plant = $(@)

    # Set hidden field value.
    card_id = power_plant.data('id')
    $('#new_auction').find('#auction_card_id').val(card_id)

    # Highlight card.
    selected_class = 'selected'
    power_plant
      .closest('.power_plant_market')
      .find('.power_plant')
      .removeClass(selected_class)
    power_plant.addClass(selected_class)

window.show_markets = ->
  $('#markets').collapse('show')

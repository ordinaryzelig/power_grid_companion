$(document).on 'turbolinks:load', ->

  auction_form = $('#new_auction')
  auction_form.find('.power_plant').on 'click', ->
    power_plant = $(@)

    # Highlight card.
    card_id = power_plant.data('id')
    auction_form.find('#auction_card_id').val(card_id)
    selected_class = 'selected'
    power_plant
      .closest('.power_plant_market')
      .find('.power_plant')
      .removeClass(selected_class)
    power_plant.addClass(selected_class)

    # Submit but with rails confirm.
    auction_form.submit Rails.handleConfirm
    auction_form.trigger 'submit'

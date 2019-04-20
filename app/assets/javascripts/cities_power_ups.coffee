$(document).on 'turbolinks:load', ->

  power_plants = $('#new_cities_power_up .power_plant')
  payments_table = $('#payments_table')

  power_plants.find('.resource_token').on 'click', ->
    token = $(@)
    token.toggleClass('selected')
    update_resource_count(token)
    update_powered_cities_count()

  update_resource_count = (token) ->
    power_plant = token.closest('.power_plant')
    selected = power_plant.find(""".resource_token.selected[data-kind="#{token.data('kind')}"]""")
    input = power_plant.find("""input[data-kind="#{token.data('kind')}"]""")
    input.val(selected.length)

    powered = parseInt(power_plant.data('resources-required')) == selected.length
    power_plant.toggleClass('powered', powered)

  update_powered_cities_count = ->
    possible_capacity = 0
    cities = $('#new_cities_power_up').data('cities')
    $.map power_plants.filter('.powered'), (power_plant) ->
      possible_capacity += parseInt($(power_plant).data('cities'))
    num_powered = Math.min(cities, possible_capacity)
    selected_class = 'table-success'
    payments_table.find(".#{selected_class}").removeClass(selected_class)
    payments_table.find("""*[data-cities="#{num_powered}"]""").addClass(selected_class)

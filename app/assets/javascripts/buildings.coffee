$(document).on 'turbolinks:load', ->

  calculator_ele = $('#building_calculator')

  calculator_ele.find('a.new_building').on 'click', (event) ->
    link = $(event.target)
    template = render_template {building_cost: link.data('building-cost')}
    calculator_ele.find('.rows').append(template)
    event.preventDefault()
    update_total()
    $('.connection_cost:last').focus()

  $(document).on 'click', '#new_buildings a.delete', ->
    $(@).parents('.building_fields').remove()
    update_total()

  update_total = ->
    building_costs = 0
    calculator_ele.find('.building_cost, .connection_cost').each ->
      val = $(@).val()
      building_costs += parseInt(val) || 0
    calculator_ele.find('.total').html("#{building_costs}€")

  $(document).on 'keyup', '#building_calculator .connection_cost', update_total

  render_template = (atts) ->
    select_options = ''
    for cost in [10, 15, 20]
      selected = atts.building_cost == cost
      if selected
        selected_attr = 'selected="selected"'
      else
        selected_attr = ''
      select_options +=
        """
        <option value="#{cost}" #{selected_attr}>#{cost}</option>
        """

    """
    <div class="building_fields form-row">
      <div class="form-group col-1">
        <label for="buildings[][building_cost]"><i class="fas fa-home"></i></label>
      </div>
      <div class="form-group col-4">
        <select class="building_cost form-control" name="buildings[][building_cost]" id="buildings[][building_cost]">
          #{select_options}
        </select>
      </div>
      <div class="form-group col-6">
        <input placeholder="Connection cost" class="connection_cost form-control" type="number" name="buildings[][connection_cost]" id="buildings[][connection_cost]">
      </div>
      <div class="form-group col-1">
        <a class="delete text-danger">
          <i class="fas fa-times-circle"></i>
        </a>
      </div>
    </div>
    """

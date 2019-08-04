window.setup_resource_transfer = ->

  $('#player_mats').collapse('show')
  resources_field = $('#_resource_transfer_resource_ids')

  current_mat = $('.player_mat.current')
  current_mat.find('.resource_token').click ->
    token = $(@)
    token.toggleClass('selected')
    selected_resources = JSON.parse(if resources_field.val() == '' then '[]' else resources_field.val())
    token_id = token.data('id')
    if token.hasClass('selected')
      selected_resources.push token_id
    else
      selected_resources.splice(selected_resources.indexOf(token_id), 1)
    resources_field.val(JSON.stringify(selected_resources))

  current_mat.find('.resource_transfer input').change ->
    current_mat.find('#_resource_transfer_card_id').val($(@).val())

jQuery.fn.extend
  magic_update: (attribute, value) ->
    @each ->
      $(@).find(".#{attribute}:first").html(value)

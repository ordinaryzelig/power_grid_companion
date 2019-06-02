$.fn.extend

  # data() doesn't update the DOM. jQuery says to use attr.
  # This is just a helper to do that.
  setData: (data) ->
    for key, val of data
      data_key = "data-#{key.replace('_', '-')}"
      @.attr(data_key, val)
    @

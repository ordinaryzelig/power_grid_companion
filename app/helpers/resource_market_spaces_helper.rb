module ResourceMarketSpacesHelper

  def resource_market_space(space)
    options = {}
    options[:class] = %w[resource_market_space]
    options[:data] = {:kind => space.kind}
    content =
      if space.resource
        options[:class] << 'occupied'
        resource_token(space.resource)
      else
        resource_icon(space.kind)
      end
    content_tag :div, content, options
  end

end

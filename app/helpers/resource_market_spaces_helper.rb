module ResourceMarketSpacesHelper

  def resource_market_space_box(space)
    options = {}
    options[:class] = ['resource_market_space']
    options[:class] << 'occupied' if space.resource.present?
    options[:data] = {:kind => space.kind}
    content_tag :div, options do
      resource_icon(space.kind)
    end
  end

end

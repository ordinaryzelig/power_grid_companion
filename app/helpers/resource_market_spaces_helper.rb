module ResourceMarketSpacesHelper

  def resource_market_space_box(space)
    options = {}
    options[:class] = ['resource_market_space']
    options[:class] << space.kind
    options[:class] << 'occupied' if space.resource.present?
    content_tag :div, options do
      resource_icon(space.kind)
    end
  end

end

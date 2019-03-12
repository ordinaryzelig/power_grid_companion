module ResourceMarketSpacesHelper

  ICONS = {
    'coal'    => ['fas', 'cloud'],
    'oil'     => ['fas', 'database'],
    'uranium' => ['fas', 'radiation-alt'],
    'trash'   => ['far', 'trash-alt'],
  }

  def resource_market_space_box(space)
    options = {}
    options[:class] = ['resource_market_space']
    options[:class] << space.kind
    options[:class] << 'occupied' if space.resource.present?
    content_tag :div, options do
      icon(*ICONS.fetch(space.kind))
    end
  end

end

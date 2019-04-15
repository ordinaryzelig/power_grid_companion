module IconsHelper

  ICONS = {
    :coal                         => ['fas', 'cloud'],
    :oil                          => ['fas', 'database'],
    :uranium                      => ['fas', 'radiation-alt'],
    :trash                        => ['far', 'trash-alt'],
    :house                        => ['fas', 'home'],
    :resources_power_cities_arrow => ['fas', 'long-arrow-alt-right'],
    :bolt                         => ['fas', 'bolt'],
    :circle                       => ['far', 'circle'],
    :check_circle                 => ['far', 'check-circle'],
  }

  def house_icon
    icon(*ICONS.fetch(:house))
  end

  def resource_icon(resource)
    icon(*ICONS.fetch(resource.to_sym))
  end

  def resources_power_cities_arrow_icon
    icon(*ICONS.fetch(:resources_power_cities_arrow), :class => 'arrow_right')
  end

  def bolt_icon
    icon(*ICONS.fetch(:bolt))
  end

  def circle_icon
    icon(*ICONS.fetch(:circle))
  end

  def check_circle_icon
    icon(*ICONS.fetch(:check_circle))
  end

end

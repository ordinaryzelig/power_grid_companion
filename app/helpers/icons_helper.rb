module IconsHelper

  ICONS = {
    :coal         => ['fas', 'cloud'],
    :oil          => ['fas', 'database'],
    :uranium      => ['fas', 'radiation-alt'],
    :trash        => ['far', 'trash-alt'],
    :house        => ['fas', 'home'],
    :bolt         => ['fas', 'bolt'],
    :circle       => ['far', 'circle'],
    :check_circle => ['far', 'check-circle'],
    :users        => ['fas', 'users'],
    :industry     => ['fas', 'industry'],
    :recycle      => ['fas', 'recycle'],
    :renewable    => ['fas', 'wind'],
  }

  def house_icon
    icon(*ICONS.fetch(:house))
  end

  def resource_icon(resource)
    icon(*ICONS.fetch(resource.to_sym))
  end

  def resource_icons(resources, resources_required)
    if resources.size == 1
      [resources_required, 1].max.times.map do
        icon(*ICONS.fetch(resources.first.to_sym))
      end.join(' ').html_safe
    else
      content_tag :small do
        icons =
          resources.map do |resource|
            icon(*ICONS.fetch(resource.to_sym))
          end
        "#{icons.join('/')} x #{resources_required}".html_safe
      end
    end
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

  def players_icon
    icon(*ICONS.fetch(:users))
  end

  def market_icon
    icon(*ICONS.fetch(:industry))
  end

  def resources_icons
    %i[coal oil uranium trash].map do |type|
      icon(*ICONS.fetch(type))
    end.join.html_safe
  end

  def replenishment_icon
    icon(*ICONS.fetch(:recycle))
  end

end

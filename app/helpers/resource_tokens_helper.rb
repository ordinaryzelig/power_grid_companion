module ResourceTokensHelper

  def resource_token(resource)
    content_tag :div, nil, :class => %w[resource_token], :data => resource.attributes
  end

end

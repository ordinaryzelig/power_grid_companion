module ResourceTokensHelper

  def resource_token(resource)
    content_tag :div, nil, :class => %w[resource_token], :data => {:kind => resource.kind}
  end

end

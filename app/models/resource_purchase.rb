class ResourcePurchase

  def initialize(player, resource_params)
    @player          = player
    @resource_params = resource_params
  end

  def save!
    @resource_params.each do |resource_kind, num|
      resources =
        @player.game.resource_market_spaces
          .occupied
          .send(resource_kind)
          .first(Integer(num))
          .map(&:resource)
      purchase_resources(resources)
    end
  end

  def purchase_resources(resources)
    resources.each(&@player.method(:purchase_resource))
  end

end

class ResourcePurchase

  def initialize(player, resource_params)
    @player          = player
    @resource_params = resource_params
  end

  def save!
    @resource_params.each do |resource_kind, num|
      resources = @player.game.resources_of_kind(resource_kind).available.limit(Integer(num))
      @player.purchase_resources(resources)
    end
  end

end

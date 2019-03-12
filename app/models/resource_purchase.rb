class ResourcePurchase

  def initialize(player, resource_params)
    @player          = player
    @resource_params = resource_params
  end

  def save!
    @resource_params.each do |resource_kind, num|
      resources =
        @player.game.resources_of_kind(resource_kind)
          .purchasable
          .sort_by(&:cost)
          .take(Integer(num))
      purchase_resources(resources)
    end
  end

  def purchase_resources(resources)
    Player.transaction do
      @player.update!(:balance => @player.balance - resources.map(&:cost).reduce(:+))
      resources.each { |resource| resource.update!(:owner => @player) }
    end
  end

end

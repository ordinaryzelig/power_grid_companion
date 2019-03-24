class ResourcePurchase

  extend ActiveModel::Naming
  include ActiveModel::Conversion

  def initialize(player, resource_params)
    @player          = player
    @resource_params = resource_params
  end

  def save!
    purchase_resources(resources)
  end

  def purchase_resources(resources)
    resources.each(&@player.method(:purchase_resource))
  end

  def persisted?
    false
  end

  Resource.kinds.keys.each do |kind|
    define_method kind do
      @resource_params.fetch(kind, 0)
    end
  end

  def cost
    resources.sum(&:cost)
  end

private

  def resources
    @resources ||=
      @resource_params.to_unsafe_h.flat_map do |resource_kind, num|
        @player.game.resource_market_spaces
          .occupied
          .send(resource_kind)
          .first(Integer(num))
          .map(&:resource)
      end
  end

end

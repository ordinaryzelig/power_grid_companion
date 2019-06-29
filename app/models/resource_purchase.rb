class ResourcePurchase

  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_reader :cost

  def initialize(player, resource_params, options = {})
    @player          = player
    @resource_params = resource_params
    @options         = options
  end

  def save!
    authorize_player unless @options[:skip_authorization]
    # Need to calculate before actual purchase because the resource will not belong to
    # the ResourceMarketSpace anymore, and we will not get cost.
    calculate_cost
    purchase_resources
  end

  def purchase_resources
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

  def calculate_cost
    @cost = resources.sum(&:cost)
  end

  def resources
    @resources ||=
      @resource_params.keys.flat_map do |resource_kind|
        @player.game.resource_market_spaces
          .occupied
          .send(resource_kind)
          .first(Integer(@resource_params.fetch(resource_kind)))
          .map(&:resource)
      end
  end

private

  def authorize_player
    unless @player.id == @player.game.current_player.id
      raise "Wrong player (#{@player.id}) turn. Only player that can do anything is #{@player.game.current_player.name} (#{@player.game.current_player.id})."
    end
  end

end

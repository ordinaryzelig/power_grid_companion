class ResourceMarketSpace < ApplicationRecord

  belongs_to :game
  has_one :resource

  extend EnumResourceKind

  default_scope -> { order(:cost) }

  COSTS = [
     1,
     2,
     3,
     4,
     5,
     6,
     7,
     8,
    10,
    12,
    14,
    16,
  ]
  URANIUM_ONLY_COSTS = [10, 12, 14, 16]

  STARTING_MARKET = {
    :coal    => 24,
    :oil     => 18,
    :uranium => 2,
    :trash   => 6,
  }

  class << self

    def setup(game)
      # Build all spaces.
      (COSTS - URANIUM_ONLY_COSTS).each do |cost|
        (Resource.kinds.keys - ['uranium']).each do |kind|
          3.times do
            game.resource_market_spaces.build(
              :cost => cost,
              :kind => kind,
            )
          end
        end
        game.resource_market_spaces.build(
          :cost => cost,
          :kind => :uranium,
        )
      end
      URANIUM_ONLY_COSTS.each do |cost|
        game.resource_market_spaces.build(
          :cost => cost,
          :kind => :uranium,
        )
      end

      game.save!

      # Fill spaces according to STARTING_COSTS.
      free_spaces_by_kind = game.resource_market_spaces.group_by(&:kind)
      STARTING_MARKET.each do |kind, num|
        assigned_resources = game.resources_of_kind(kind).general_supply.limit(num)
        assigned_resources.each do |resource|
          resource.update!(:owner => free_spaces_by_kind.fetch(kind.to_s).pop)
        end
      end
    end

  end

end

class ResourceMarketSpace < ApplicationRecord

  belongs_to :game
  has_resources :as => :owner

  default_scope -> { order(:cost) }

  STARTING_COSTS = {
    1  => {:coal => 3, :oil => 0, :uranium => 0, :trash => 0},
    2  => {:coal => 3, :oil => 0, :uranium => 0, :trash => 0},
    3  => {:coal => 3, :oil => 3, :uranium => 0, :trash => 0},
    4  => {:coal => 3, :oil => 3, :uranium => 0, :trash => 0},
    5  => {:coal => 3, :oil => 3, :uranium => 0, :trash => 0},
    6  => {:coal => 3, :oil => 3, :uranium => 0, :trash => 0},
    7  => {:coal => 3, :oil => 3, :uranium => 0, :trash => 3},
    8  => {:coal => 3, :oil => 3, :uranium => 0, :trash => 3},
    10 => {:coal => 0, :oil => 0, :uranium => 0, :trash => 0},
    12 => {:coal => 0, :oil => 0, :uranium => 0, :trash => 0},
    14 => {:coal => 0, :oil => 0, :uranium => 1, :trash => 0},
    16 => {:coal => 0, :oil => 0, :uranium => 1, :trash => 0},
  }
  URANIUM_ONLY_COSTS = [10, 12, 14, 16]

  class << self

    def setup(game)
      STARTING_COSTS.each do |cost, starting_resources|
        resource_market_space = game.resource_market_spaces.create!(:cost => cost)
        starting_resources.each do |kind, num|
          assigned_resources = game.resources_of_kind(kind).general_supply.limit(num)
          resource_market_space.resources.concat assigned_resources
        end
      end
    end

  end

end

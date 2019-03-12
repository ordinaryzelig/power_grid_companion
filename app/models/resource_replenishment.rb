class ResourceReplenishment

  # player => step => kind => num.
  RATES = {
    2 => {
      1 => {
        :coal    => 3,
        :oil     => 2,
        :trash   => 1,
        :uranium => 1,
      },
      2 => {
        :coal    => 4,
        :oil     => 2,
        :trash   => 2,
        :uranium => 1,
      },
      3 => {
        :coal    => 3,
        :oil     => 4,
        :trash   => 3,
        :uranium => 1,
      },
    },
    3 => {
      1 => {
        :coal    => 4,
        :oil     => 2,
        :trash   => 1,
        :uranium => 1,
      },
      2 => {
        :coal    => 5,
        :oil     => 3,
        :trash   => 2,
        :uranium => 1,
      },
      3 => {
        :coal    => 3,
        :oil     => 4,
        :trash   => 3,
        :uranium => 1,
      },
    },
    4 => {
      1 => {
        :coal    => 5,
        :oil     => 3,
        :trash   => 2,
        :uranium => 1,
      },
      2 => {
        :coal    => 6,
        :oil     => 4,
        :trash   => 3,
        :uranium => 2,
      },
      3 => {
        :coal    => 4,
        :oil     => 5,
        :trash   => 4,
        :uranium => 2,
      },
    },
    5 => {
      1 => {
        :coal    => 5,
        :oil     => 4,
        :trash   => 3,
        :uranium => 2,
      },
      2 => {
        :coal    => 7,
        :oil     => 5,
        :trash   => 3,
        :uranium => 3,
      },
      3 => {
        :coal    => 5,
        :oil     => 6,
        :trash   => 5,
        :uranium => 2,
      },
    },
    6 => {
      1 => {
        :coal    => 7,
        :oil     => 5,
        :trash   => 3,
        :uranium => 2,
      },
      2 => {
        :coal    => 9,
        :oil     => 6,
        :trash   => 5,
        :uranium => 3,
      },
      3 => {
        :coal    => 6,
        :oil     => 7,
        :trash   => 6,
        :uranium => 3,
      },
    },
  }

  def initialize(game)
    @game = game
  end

  def save!
    @game.replenishment_rates.each do |kind, num|
      supply_resources = @game.resources_of_kind(kind).general_supply.limit(num)
      free_spaces = @game.resource_market_spaces.send(kind).unoccupied.last(supply_resources.count)
      supply_resources.each do |resource|
        free_space = free_spaces.pop
        resource.update!(:owner => free_space)
        free_space.update!(:occupied => true)
      end
    end
  end

end

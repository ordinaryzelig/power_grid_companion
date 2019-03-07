class Resource < ApplicationRecord

  belongs_to :game
  belongs_to :market_space, :foreign_key => :resource_market_space_id, :class_name => 'ResourceMarketSpace', :optional => true
  belongs_to :player, :optional => true

  scope :available, -> { joins(:market_space).order('resource_market_spaces.cost') }

  enum :kind => {
    :coal    => 1,
    :oil     => 2,
    :uranium => 3,
    :trash   => 4,
  }

  class << self

    def setup!(game)
      ResourceMarketSpace::STARTING_COSTS.keys.each do |cost|
        unless ResourceMarketSpace::URANIUM_ONLY_COSTS.include?(cost)
          %i[coal oil trash].each do |kind|
            3.times do
              game.resources_of_kind(kind).create!
            end
          end
        end
        game.resources_of_kind(:uranium).create!
      end
    end

  end

  def cost
    market_space&.cost
  end

end

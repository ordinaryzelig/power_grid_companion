class Resource < ApplicationRecord

  belongs_to :game
  belongs_to :owner, :polymorphic => true, :optional => true

  scope :purchasable, -> { where(:owner_type => 'ResourceMarketSpace') }
  scope :general_supply, -> { where(:owner_type => nil) }

  enum :kind => {
    :coal    => 1,
    :oil     => 2,
    :uranium => 3,
    :trash   => 4,
  }

  class << self

    def setup(game)
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
    owner.cost
  end

end

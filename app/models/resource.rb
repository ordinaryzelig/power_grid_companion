class Resource < ApplicationRecord

  belongs_to :game
  belongs_to :owner, :polymorphic => true, :optional => true

  validates :owner_type, :inclusion => {:in => ['Card', 'ResourceMarketSpace']}, :if => :owner_type

  scope :purchasable, -> { where(:owner_type => 'ResourceMarketSpace') }
  scope :general_supply, -> { where(:owner_type => nil) }

  extend EnumResourceKind

  class << self

    def setup(game)
      ResourceMarketSpace::COSTS.each do |cost|
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

    def return_to_general_supply
      update_all(:owner_type => nil, :owner_id => nil)
    end

  end

  def cost
    if owner.is_a?(ResourceMarketSpace)
      owner.cost
    end
  end

  def move_to(new_owner)
    if owner.is_a?(ResourceMarketSpace)
      owner.update!(:occupied => false)
    end
    update!(:owner => new_owner == :general_supply ? nil : new_owner)
  end

  def return_to_general_supply
    move_to(:general_supply)
  end

end

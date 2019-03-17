class Game < ApplicationRecord

  has_many :players
  has_resources
  has_many :resource_market_spaces
  has_many :cards
  has_many :auctions
  belongs_to :current_player, :optional => true, :class_name => 'Player'

  accepts_nested_attributes_for :players

  before_validation :generate_token, :unless => :token
  before_validation :randomize_turn_order, :on => :create

  after_create :setup

  def setup
    self.current_player = players.min_by(&:turn_order)
    Resource.setup(self)
    ResourceMarketSpace.setup(self)
    Card.setup(self)
    save!
  end

  def replenishment_rates
    ResourceReplenishment::RATES.fetch(players.size).fetch(step)
  end

private

  def generate_token
    self.token = SecureRandom.hex(3)
  end

  def randomize_turn_order
    players.shuffle.each_with_index do |player, idx|
      player.turn_order = idx + 1
    end
  end

end

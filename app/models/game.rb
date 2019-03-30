class Game < ApplicationRecord

  has_many :players, :inverse_of => :game do
    def setup
      missing_colors = Player.colors.keys - map(&:color)
      missing_colors.each_with_index do |color, idx|
        build(:seat_position => idx + 1)
      end
      sort_by(&:seat_position)
    end
  end
  has_resources
  has_many :resource_market_spaces
  has_many :cards
  has_many :auctions
  belongs_to :current_player, :optional => true, :class_name => 'Player'

  accepts_nested_attributes_for :players, :reject_if => -> (atts) { atts.values_at(:name, :color).all?(&:blank?) }

  before_validation :generate_token, :unless => :token
  before_validation :randomize_turn_order, :on => :create

  validate :at_least_2_players, :on => :create

  after_create :setup

  enum(
    :phase => {
      :turn_order       => 1,
      :auction          => 2,
      :buying_resources => 3,
      :building         => 4,
      :bureaucracy      => 5,
    },
  )

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

  def at_least_2_players
    if players.size < 2
      errors.add(:base, 'Enter at least 2 players')
    end
  end

end

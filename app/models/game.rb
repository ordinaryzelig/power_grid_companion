class Game < ApplicationRecord

  has_many :players, :inverse_of => :game do
    def setup
      missing_colors = Player.colors.keys - map(&:color)
      missing_colors.each_with_index do |color, idx|
        build(:seat_position => idx)
      end
      sort_by(&:seat_position)
    end

    def in_new_turn_order
      sort_by(&:turn_order_data)
    end
  end
  has_resources
  has_many :resource_market_spaces
  has_many :cards
  has_many :auctions

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
    self.phase_player_ids = players.in_turn_order.ids
    Resource.setup(self)
    ResourceMarketSpace.setup(self)
    Card.setup(self)
    save!
  end

  def replenishment_rates
    ResourceReplenishment::RATES.fetch(players.size).fetch(step)
  end

  def to_param
    token
  end

  def determine_turn_order
    players.in_new_turn_order.each_with_index do |player, idx|
      player.update!(:turn_order => idx)
    end
  end

  def phase_players
    @phase_players ||= players.find(phase_player_ids)
  end

  def remove_phase_player(player)
    update!(:phase_player_ids => phase_player_ids.without(player.id))
  end

  def current_player
    phase_players.first
  end

private

  def generate_token
    self.token = SecureRandom.hex(3)
  end

  def randomize_turn_order
    players.shuffle.each_with_index do |player, idx|
      player.turn_order = idx
    end
  end

  def at_least_2_players
    if players.size < 2
      errors.add(:base, 'Enter at least 2 players')
    end
  end

end

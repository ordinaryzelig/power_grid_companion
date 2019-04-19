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
      :turn_order             => 1,
      :auction                => 2,
      :resource_purchase      => 3,
      :building               => 4,
      :cities_power_up        => 5,
      :resource_replenishment => 6,
    },
  )

  def setup
    reset_phase_players
    Resource.setup(self)
    ResourceMarketSpace.setup(self)
    Card.setup(self)
    save!
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
    @phase_players ||= players.in_turn_order.where(:id => phase_player_ids)
  end

  def remove_phase_player(player)
    @phase_players = nil
    update!(:phase_player_ids => phase_player_ids.without(player.id))
  end

  def current_player
    phase_players.first
  end

  def reset_phase_players
    self.phase_player_ids = players.in_turn_order.ids
  end

  def reset_phase_players!
    reset_phase_players
    save!
  end

  def next_phase!
    reset_phase_players
    update!(:phase => next_phase)
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

  def next_phase
    case phase
    when 'turn_order'
      if round == 1 then          'resource_purchase'
      else                        'auction'
      end
    when 'auction'
      if round == 1 then          'turn_order'
      else                        'resource_purchase'
      end
    when 'resource_purchase' then 'building'
    when 'building'          then 'cities_power_up'
    when 'cities_power_up'   then 'resource_replenishment'
    else
      raise "No next phase for #{phase.inspect}"
    end
  end

end

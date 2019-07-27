class Player < ApplicationRecord

  belongs_to :game
  has_many :cards, -> { in_play }
  has_resources :through => :cards
  has_many :cities_power_ups

  validates :name, :presence => true
  validates :color, :presence => true, :uniqueness => {:scope => :game_id}
  validates :seat_position, :presence => true, :uniqueness => {:scope => :game_id}

  scope :in_turn_order, -> { order(:turn_order) }
  scope :in_seat_order, -> { order(:seat_position) }

  enum :color => {
    :blue   => 0,
    :red    => 1,
    :black  => 2,
    :green  => 3,
    :purple => 4,
    :yellow => 5,
  }

  def turn_order_data
    [-cities, -cards.map(&:number).max]
  end

  def purchase_resource(resource)
    self.balance -= resource.cost
    cards_with_space = cards.send(resource.kind).select(&:has_space?)
    card = cards_with_space.min_by { |c| c.selected_kinds.size }
    raise "No space to put purchased resource" unless card
    resource.move_to(card)
    save!
  end

  def purchase_card(card, price)
    card.update!(:player => self)
    update!(:balance => balance - price)
  end

  def power_capacity
    cards.sum(&:cities)
  end

  def phase_status
    game.phase_player_ids.include?(id) ? 'incomplete' : 'complete'
  end

  def broadcast_your_turn
    PlayersChannel.your_turn(self)
  end

end

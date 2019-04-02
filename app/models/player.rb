class Player < ApplicationRecord

  belongs_to :game
  has_many :cards
  has_resources :as => :owner

  validates :name, :presence => true
  validates :color, :presence => true, :uniqueness => {:scope => :game_id}
  validates :seat_position, :presence => true, :uniqueness => {:scope => :game_id}

  scope :in_turn_order, -> { order(:turn_order) }
  scope :in_seat_order, -> { order(:seat_position) }
  scope :starting_with, -> (player) { where('turn_order >= ?', player.turn_order) }

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
    card = cards.send(resource.kind).detect(&:has_space?)
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

end

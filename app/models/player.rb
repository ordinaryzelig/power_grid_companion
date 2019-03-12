class Player < ApplicationRecord

  belongs_to :game
  has_many :cards
  has_resources :as => :owner

  scope :in_turn_order, -> { order(:turn_order) }
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

end

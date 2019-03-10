class Auction < ApplicationRecord

  belongs_to :game
  belongs_to :card
  belongs_to :player

  before_validation :set_initial_price, :on => :create
  before_validation :set_bidders, :on => :create

private

  def set_initial_price
    self.price = card.number
  end

  def set_bidders
    self.bidders = game.players.in_turn_order.starting_with(player).map(&:id)
  end

end

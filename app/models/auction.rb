class Auction < ApplicationRecord

  belongs_to :game
  belongs_to :card
  belongs_to :player

  before_validation :set_bidders, :on => :create

  def bid_by(bidder)
    self.class.transaction do
      raise "Wrong player (#{bidder.id}) bid. Next bidder is #{bidders.first}" unless bidders.first == bidder.id

      increment_price
      if bidders.size == 1
        sell_to bidder
      else
        cycle_bidders
      end

      save!
    end
  end

private

  def set_bidders
    self.bidders = game.players.in_turn_order.starting_with(player).map(&:id)
  end

  def increment_price
    self.price = price? ? price + 1 : card.number
  end

  def cycle_bidders
    bidders.push bidders.pop
  end

  def sell_to(bidder)
    card.update!(:player => bidder)
    player.update!(:balance => player.balance - price)
  end

end

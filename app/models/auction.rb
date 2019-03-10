class Auction < ApplicationRecord

  belongs_to :game
  belongs_to :card
  belongs_to :player

  before_validation :set_initial_bidding_order, :on => :create

  def bid_by(bidder)
    self.class.transaction do
      raise "Wrong player (#{bidder.id}) bid. Next bidder is #{bidder_ids.first}" unless bidder_ids.first == bidder.id

      increment_price
      if bidder_ids.size == 1
        sell_to bidder
      else
        cycle_bidders
      end

      save!
    end
  end

  def bidders
    Player.find(bidder_ids)
  end

private

  def set_initial_bidding_order
    self.bidder_ids = game.players.in_turn_order.starting_with(player).map(&:id)
  end

  def increment_price
    self.price = price? ? price + 1 : card.number
  end

  def cycle_bidders
    bidder_ids.push bidder_ids.shift
  end

  def sell_to(bidder)
    card.update!(:player => bidder)
    player.update!(:balance => player.balance - price)
  end

end

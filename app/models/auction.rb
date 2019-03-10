class Auction < ApplicationRecord

  belongs_to :game
  belongs_to :card
  belongs_to :player

  before_validation :set_initial_bidding_order, :on => :create

  def bid_by(bidder)
    self.class.transaction do
      authorize_player bidder

      increment_price
      if bidder_ids.size == 1
        sell_to bidder
      else
        cycle_bidders
      end

      save!
    end
  end

  def pass_by(player)
    authorize_player player

    bidder_ids.shift
    if bidder_ids.size == 1
      sell_to bidders.first
    end
    save!
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

  def sell_to(player)
    card.update!(:player => player)
    player.update!(:balance => player.balance - price)
  end

  def authorize_player(player)
    raise "Wrong player (#{player.id}) turn. Only player that can do anything is #{bidder_ids.first}" unless bidder_ids.first == player.id
  end

end

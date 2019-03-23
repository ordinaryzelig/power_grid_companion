class Auction < ApplicationRecord

  belongs_to :game
  belongs_to :card
  belongs_to :player

  before_validation :set_initial_bidding_order, :on => :create

  def bid_by(bidder)
    self.class.transaction do
      authorize_player bidder

      increment_price
      cycle_bidders

      save!
    end
  end

  def pass_by(player)
    authorize_player player

    bidder_ids.shift
    save!
  end

  def bidders
    Player.find(bidder_ids)
  end

  def claim(card_to_replace)
    card_to_replace&.update!(:player => nil)
    sell_to bidders.first
  end

  def player_turn
    bidders.first
  end

  def player_turn?(player)
    player_turn.tap(&method(:ap)) == player.tap(&method(:ap))
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
    player.purchase_card(card, price)
  end

  def authorize_player(player)
    raise "Wrong player (#{player.id}) turn. Only player that can do anything is #{bidder_ids.first}" unless player_turn?(player)
  end

end

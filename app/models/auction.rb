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
    player = bidders.first
    sell_to player
    game.remove_phase_player(player)
  end

  def player_turn
    bidders.first
  end

  def player_turn?(player)
    player_turn == player
  end

  def open?
    bidder_ids.size > 1
  end

private

  def set_initial_bidding_order
    player_ids = game.players.in_seat_order.ids
    player_idx = player_ids.index(player.id)
    self.bidder_ids = player_ids.each_with_index.map do |player_id, idx|
      player_ids.fetch(player_idx - idx)
    end
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
    raise "Wrong player (#{player.id}) turn. Only player that can do anything is #{bidders.first.name} (#{bidders.first.id})" unless player_turn?(player)
  end

end

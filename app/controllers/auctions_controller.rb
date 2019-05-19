class AuctionsController < ApplicationController

  before_action :set_auction, :only => %i[show bid pass claim]
  before_action :set_turn, :only => %i[new]
  before_action :set_bid_turn, :only => %i[show]

  def new
    @auction = current_game.auctions.new
  end

  def create
    auction_atts = auction_params.merge(
      :player_id => current_player.id,
    )
    auction = current_game.auctions.create!(auction_atts)
    auction.bid_by current_player
    redirect_to auction
  end

  def show
  end

  def bid
    @auction.bid_by current_player
    redirect_to @auction
  end

  def pass
    @auction.pass_by current_player
    redirect_to @auction
  end

  def claim
    card_to_replace = current_game.cards.find(params[:card_to_replace_id]) if params[:card_to_replace_id]
    @auction.claim(card_to_replace)
    current_game.cards.draw_deck.shuffle! if current_game.cards.last_drawn.step_3?
    next_player_or_next_phase
  end

  def skip
    current_game.remove_phase_player(current_player)
    next_player_or_next_phase
  end

private

  def auction_params
    params
      .require(:auction)
      .permit(
        :card_id,
      )
  end

  def set_auction
    @auction = current_game.auctions.find(params[:id])
  end

  def set_turn
    @your_turn = current_game.current_player == current_player
  end

  def set_bid_turn
    @your_turn = @auction.player_turn?(current_player)
  end

end

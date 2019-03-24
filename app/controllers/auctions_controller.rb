class AuctionsController < ApplicationController

  before_action :set_auction, :only => %i[show bid pass claim]
  before_action :set_turn, :only => %i[show]

  def new
    @auction = current_game.auctions.new
  end

  def create
    auction_atts = auction_params.merge(
      :player_id => current_player.id,
      :round     => current_game.round,
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
    redirect_to [:new, @auction]
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
    @your_turn = @auction.player_turn?(current_player)
  end

end

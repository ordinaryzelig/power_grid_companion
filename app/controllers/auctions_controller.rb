class AuctionsController < ApplicationController

  before_action :set_auction, :only => %i[bid pass]

  def create
    auction_atts = auction_params.merge(
      :player_id => current_player.id,
    )
    auction = current_game.auctions.create!(auction_atts)
    auction.bid_by current_player
  end

  def bid
    @auction.bid_by current_player
  end

  def pass
    @auction.pass_by current_player
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
    @auction = Auction.find(params[:id])
  end

end

class AuctionsController < ApplicationController

  def create
    auction_atts = auction_params.merge(
      :player_id => current_player.id,
    )
    auction = current_game.auctions.create!(auction_atts)
    auction.bid_by current_player
  end

private

  def auction_params
    params
      .require(:auction)
      .permit(
        :card_id,
      )
  end

end

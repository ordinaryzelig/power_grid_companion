class TurnOrdersController < ApplicationController

  def new
    @new_turn_order_players = current_game.players.in_new_turn_order
  end

  def create
    current_game.determine_turn_order
    if current_game.round == 1
      redirect_to [:new, :resource_purchase]
    else
      redirect_to new_auction_url
    end
  end

end

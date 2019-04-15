class TurnOrdersController < ApplicationController

  def new
    @new_turn_order_players = current_game.players.in_new_turn_order
  end

  def create
    current_game.determine_turn_order
    if current_game.round == 1
      current_game.next_phase(:buying_resources)
      redirect_to [:new, :resource_purchase]
    else
      current_game.next_phase(:auction)
      redirect_to [:new, :auction]
    end
  end

end

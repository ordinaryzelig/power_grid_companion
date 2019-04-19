class TurnOrdersController < ApplicationController

  def new
    @new_turn_order_players = current_game.players.in_new_turn_order
  end

  def create
    current_game.determine_turn_order
    current_game.next_phase!
    redirect_to [:new, current_game.phase]
  end

end

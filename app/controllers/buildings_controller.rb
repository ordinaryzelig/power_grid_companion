class BuildingsController < ApplicationController

  def new
  end

  def create
    buildings = Buildings.new(current_player, buildings_params)
    buildings.save!
    next_player_or_next_phase
  end

  def pass
    current_game.remove_phase_player(current_player)
    next_player_or_next_phase
  end

private

  def buildings_params
    params
      .permit(
        :buildings => [
          :connection_cost,
          :building_cost,
        ],
      )
  end

  def next_player_or_next_phase
    if current_game.phase_players.any?
      redirect_to [:new, :building]
    else
      current_game.next_phase(:building)
      redirect_to [:new, :turn_order]
    end
  end

end

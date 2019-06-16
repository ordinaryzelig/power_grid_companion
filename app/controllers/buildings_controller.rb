class BuildingsController < ApplicationController

  def new
  end

  def create
    buildings = Buildings.new(current_player, buildings_params)
    buildings.save!
    current_game.remove_phase_player(current_player)
    current_game.broadcast
    current_game.broadcast_log "#{current_player.name} built #{buildings.cities} for #{buildings.total_cost}€."
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

  def render_building_form?
    true
  end

end

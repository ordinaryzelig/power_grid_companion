class CitiesPowerUpsController < ApplicationController

  before_action :set_turn

  def new
    @cities_power_up = CitiesPowerUp.new
  end

  def create
    cities_power_up = current_player.cities_power_ups.build(cities_power_up_params)
    cities_power_up.save!
    current_player.game.remove_phase_player(current_player)
    redirect_to cities_power_ups_url
  end

  def pass
    cities_power_ups = current_player.cities_power_ups.pass!
    redirect_to cities_power_ups_url
  end

private

  def cities_power_up_params
    params
      .require(:cities_power_up)
      .permit(
        :cards => [
          :id,
          *Resource.kinds.keys,
        ],
      )
  end

  def set_turn
    @your_turn = current_game_player == current_player
  end

end

class CitiesPowerUpsController < ApplicationController

  before_action :set_turn

  def new
    @cities_power_up = CitiesPowerUp.new(current_player, {})
  end

  def create
    cities_power_up = CitiesPowerUp.new(current_player, cities_power_up_params)
    cities_power_up.save!
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

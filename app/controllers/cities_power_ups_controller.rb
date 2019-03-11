require 'test_helper'

class CitiesPowerUpsController < ApplicationController

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

end

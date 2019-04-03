class BuildingsController < ApplicationController

  def new
  end

  def create
    buildings = Buildings.new(current_player, buildings_params)
    buildings.save!
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

end

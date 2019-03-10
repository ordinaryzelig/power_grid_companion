class GamesController < ApplicationController

  def create
    game = Game.create!(game_params)
  end

private

  def game_params
    params
      .require(:game)
      .permit(
        :players_attributes => [
          :name,
          :color,
        ],
      )
  end

end

class GamesController < ApplicationController

  def create
    game = Game.create!(game_params)
  end

  def show
    @game = Game.find(params[:id])
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

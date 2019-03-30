class GamesController < ApplicationController

  def new
    @game = Game.new
    @game.players.setup
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to game_url(@game)
    else
      @game.players.setup
      render :new
    end
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
          :seat_position,
        ],
      )
  end

end

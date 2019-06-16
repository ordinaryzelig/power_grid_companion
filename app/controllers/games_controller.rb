class GamesController < ApplicationController

  def new
    @game = Game.new
    @game.players.setup
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      @game.setup
      redirect_to new_auction_url
    else
      @game.players.setup
      render :new
    end
  end

  def show
    game = Game.find_by!(:token => params[:id])
    redirect_to [:new, game.phase]
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

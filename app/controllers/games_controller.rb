class GamesController < ApplicationController

  before_action :logout_player, :only => [:new, :join]
  before_action :set_game, :only => %i[show join]
  before_action :hide_turn_order, :only => %i[join]

  def new
    @game = Game.new
    @game.players.setup
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      @game.setup
      redirect_to join_game_url(@game)
    else
      @game.players.setup
      render :new
    end
  end

  def show
    redirect_to [:new, @game.phase]
  end

  def join
    @subscribe_to_game = @game
  end

private

  def set_game
    @game = Game.find_by!(:token => params[:id])
  end

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

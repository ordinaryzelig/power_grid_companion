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
    game = Game.find_by!(:token => params[:id])
    case game.phase
    when 'auction'
      redirect_to new_auction_url
    when 'buying_resources'
      redirect_to new_resource_purchase_url
    else
      raise "Don't know how to navigate to #{game.phase.inspect}"
    end
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

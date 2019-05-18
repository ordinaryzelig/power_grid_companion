class CardsController < ApplicationController

  def index
    @game = Game.find_by!(:token => params[:game_id])
  end

end

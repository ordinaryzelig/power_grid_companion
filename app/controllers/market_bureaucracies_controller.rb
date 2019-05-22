class MarketBureaucraciesController < ApplicationController

  def new
    @market_bureaucracy = MarketBureaucracy.new(current_game)
  end

  def create
    MarketBureaucracy.new(current_game).save!
    redirect_to market_bureaucracies_url
  end

  def index
  end

end

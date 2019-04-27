class MarketBureaucraciesController < ApplicationController

  def new
    @market_bureaucracy = MarketBureaucracy.new(current_game)
  end

  def create
    MarketBureaucracy.new(current_game).save!
    if current_game.cards.last_drawn.step_3?
      raise 'Step 3'
    else
      render
    end
  end

end

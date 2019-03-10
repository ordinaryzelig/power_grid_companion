class PlayersController < ApplicationController

  def claim
    cookies.signed[:player_id] = params.fetch(:id)
  end

end

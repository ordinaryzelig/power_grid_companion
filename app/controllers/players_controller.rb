class PlayersController < ApplicationController

  def claim
    player = Player.find(params.fetch(:id))
    cookies.signed[:player_id] = player.id
    if params[:debug]
      redirect_back :fallback_location => player.game
    else
      redirect_to player.game
    end
  end

end

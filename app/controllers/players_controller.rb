class PlayersController < ApplicationController

  def claim
    player = Player.find(params.fetch(:id))
    cookies.signed[:player_id] = player.id
    redirect_to player.game
  end

end

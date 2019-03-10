class ApplicationController < ActionController::Base

  def current_player
    @current_player ||= Player.find(cookies.signed[:player_id])
  end

  def current_game
    @current_game ||= current_player.game
  end

end

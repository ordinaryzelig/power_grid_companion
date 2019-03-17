class ApplicationController < ActionController::Base

private

  def current_player
    #@current_player ||= Player.find(cookies.signed[:player_id])
    @current_player ||= Game.find(1).players.first
  end
  helper_method :current_player

  def current_game
    @current_game ||= current_player.game
  end
  helper_method :current_game

end

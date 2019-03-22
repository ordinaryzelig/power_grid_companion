class ApplicationController < ActionController::Base

private

  def current_player
    @current_player ||= Player.find(cookies.signed[:player_id])
  end
  helper_method :current_player

  def current_game
    current_player.game
  end
  helper_method :current_game

  def current_game_player
    current_game.current_player
  end
  helper_method :current_game_player

end

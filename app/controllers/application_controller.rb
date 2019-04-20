class ApplicationController < ActionController::Base

  before_action :set_resource_replenishment, :if => :current_game

private

  def current_player
    @current_player ||= Player.find_by(:id => cookies.signed[:player_id]) if cookies.signed[:player_id]
  end
  helper_method :current_player

  def current_game
    current_player.game if current_player
  end
  helper_method :current_game

  def current_game_player
    current_game.current_player
  end
  helper_method :current_game_player

  def next_player_or_next_phase
    if current_game.phase_players.any?
      redirect_to [:new, current_game.phase]
    else
      current_game.next_phase!
      redirect_to [:new, current_game.phase]
    end
  end

  def set_resource_replenishment
    @resource_replenishment = ResourceReplenishment.new(current_game)
  end

  def debug?
    params[:debug]
  end
  helper_method :debug?

end

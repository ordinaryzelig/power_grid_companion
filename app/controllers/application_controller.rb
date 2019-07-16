class ApplicationController < ActionController::Base

  include AuthHelper

  before_action :set_resource_replenishment, :if => :current_game

private

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
      current_game.current_player.broadcast_your_turn
      redirect_to [:new, current_game.phase]
    else
      if current_game.cards.step_3_revealed?
        current_game.step_3!
        redirect_to step3s_url
      else
        current_game.next_phase!
        redirect_to [:new, current_game.phase]
      end
    end
  end

  def set_resource_replenishment
    @resource_replenishment = ResourceReplenishment.new(current_game)
  end

  def debug?
    params[:debug]
  end
  helper_method :debug?

  def render_building_form?
    false
  end
  helper_method :render_building_form?

  def hide_turn_order
    @hide_turn_order = true
  end

  def logout_player
    cookies.delete(:player_id)
  end

end

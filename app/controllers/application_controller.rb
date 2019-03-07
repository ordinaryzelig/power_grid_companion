class ApplicationController < ActionController::Base

  def current_player
    @current_player ||= Player.first
  end

end

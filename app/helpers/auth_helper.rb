module AuthHelper

  def current_player
    @current_player ||= find_current_player if cookies.signed[:player_id]
  end

  def find_current_player
    Player.find_by(:id => cookies.signed[:player_id])
  end

end

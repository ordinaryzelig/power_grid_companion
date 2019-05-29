class GamesChannel < ApplicationCable::Channel

  class << self

    def broadcast_player_online_status(player, status)
      broadcast_to player.game, {
        'action'    => "player_online_status_change",
        'status'    => status,
        'player_id' => player.id,
      }
    end

  end

  def subscribed
    @game_id = params.fetch(:id)
    stream_for find_game
  end

private

  def find_game
    Game.find(@game_id)
  end

end

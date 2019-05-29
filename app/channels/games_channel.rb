class GamesChannel < ApplicationCable::Channel

  class << self

    def player_online(player)
      broadcast_to player.game, {
        'action'    => 'player_online',
        'player_id' => player.id,
      }
    end

    def player_offline(player)
      broadcast_to player.game, {
        'action'    => 'player_offline',
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

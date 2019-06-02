class GamesChannel < ApplicationCable::Channel

  class << self

    def broadcast_player_online_status(player, status)
      broadcast_to player.game, {
        'action'    => "player_online_status_change",
        'status'    => status,
        'player_id' => player.id,
      }
    end

    def broadcast(game)
      data =
        {'action' => 'status'}.merge(
          game.as_json(
            :root => true,
            :include => {
              :players => {
                :methods => %i[phase_status],
                :except  => %i[balance],
              },
            },
          )
        )
      broadcast_to game, data
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

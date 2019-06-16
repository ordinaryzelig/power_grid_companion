class GamesChannel < ApplicationCable::Channel

  class << self

    def broadcast(game)
      data =
        {'action' => 'status'}.merge(
          game.as_json(
            :root => true,
            :include => {
              :players => {
                :methods => %i[
                  phase_status
                  power_capacity
                ],
                :except  => %i[
                  balance
                ],
              },
            },
          )
        )
      broadcast_to game, data
    end

    def log(game, msg)
      data = {
        'action'     => 'log',
        'message'    => msg,
        'message_id' => SecureRandom.hex(4),
      }
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

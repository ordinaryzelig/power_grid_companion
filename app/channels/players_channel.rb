class PlayersChannel < ApplicationCable::Channel

  class << self

    def broadcast(player)
      player.as_json
      data = broadcast_data(player)
      broadcast_to player, data
    end

    def broadcast_data(player)
      player.as_json(
        :root => true,
      )
    end

  end

  def subscribed
    @player_id = params.fetch(:id)
    stream_for find_player
  end

  def unsubscribed
    set_player_online_status(false)
  end

  def online
    set_player_online_status(true)
  end

private

  def find_player
    Player.find(@player_id)
  end

  def set_player_online_status(online)
    player = find_player
    player.update!(:online => online)
    player.game.broadcast
  end

end

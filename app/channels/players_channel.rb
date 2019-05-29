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
    offline
  end

  def online
    player = find_player
    self.class.broadcast(player)
    GamesChannel.player_online(player)
  end

  def offline
    player = find_player
    GamesChannel.player_offline(player)
  end

private

  def find_player
    Player.find(@player_id)
  end

end

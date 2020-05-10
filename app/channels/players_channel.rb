class PlayersChannel < ApplicationCable::Channel

  class << self

    def your_turn(player)
      data = {
        'action' => 'your_turn',
        'phase'  => player.game.phase,
      }
      broadcast_to player, data
    end

    def replace(player, replacements)
      data = {
        'actions' => replacements.map(&method(:replace_action_data)),
      }
      broadcast_to player, data
    end

  private

    def replace_action_data(replace_data)
      {'action' => 'replace'}.merge(replace_data)
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

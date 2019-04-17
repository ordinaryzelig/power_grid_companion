require 'test_helper'

class GameTest < ActiveSupport::TestCase

  test 'assigns phase Players' do
    game = Game.create!(
      :players_attributes => Player.colors.keys.each_with_index.map do |color, idx|
        {
          :color         => color,
          :name          => color,
          :seat_position => idx,
        }
      end
    )

    assert_equal game.players.in_turn_order.map(&:color), game.phase_players.map(&:color)
  end

  test '#remove_phase_player' do
    game = games(:remove_phase_player)
    player = game.phase_players.first!

    game.remove_phase_player player

    refute_includes game.phase_players.ids, player.id
  end

end

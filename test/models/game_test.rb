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

    assert_equal Player.colors.keys, game.phase_players.map(&:color)
  end

end

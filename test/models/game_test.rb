require 'test_helper'

class GameTest < ActiveSupport::TestCase

  test 'assigns first Player as current_player' do
    game = Game.create!(
      :players_attributes => Player.colors.keys.each_with_index.map do |color, idx|
        {
          :color         => color,
          :name          => color,
          :seat_position => idx,
        }
      end
    )

    assert_equal 0, game.current_player.turn_order
  end

end

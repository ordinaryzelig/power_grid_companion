require 'test_helper'

class GameTest < ActiveSupport::TestCase

  test 'assigns first Player as current_player' do
    game = Game.create!(
      :players_attributes => Player.colors.keys.map do |color|
        {
          :color => color,
          :name  => color,
        }
      end
    )

    assert_equal 1, game.current_player.turn_order
  end

end

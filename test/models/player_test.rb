require 'test_helper'

class PlayerTest < ActiveSupport::TestCase

  test 'sorting for turn order' do
    player_1 = Player.new(:cities => 2, :cards => [Card.new(:number => 3)])
    player_2 = Player.new(:cities => 2, :cards => [Card.new(:number => 4)])
    player_3 = Player.new(:cities => 1, :cards => [Card.new(:number => 5)])
    players = [player_1, player_2, player_3]

    players.sort_by!(&:turn_order_data)

    assert_equal [player_2, player_1, player_3], players
  end

end

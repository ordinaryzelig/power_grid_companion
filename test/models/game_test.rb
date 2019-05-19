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

  def self.test_next_phase(current_phase, round, expected:)
    test "next_phase after #{current_phase}, round #{round}" do
      game = Game.new(:phase => current_phase, :round => round)
      assert_equal expected, game.send(:next_phase)
    end
  end

  test_next_phase 'turn_order',             1,      :expected => 'resource_purchase'
  test_next_phase 'turn_order',             :other, :expected => 'auction'
  test_next_phase 'auction',                1,      :expected => 'turn_order'
  test_next_phase 'auction',                :other, :expected => 'resource_purchase'
  test_next_phase 'resource_purchase',      :any,   :expected => 'building'
  test_next_phase 'building',               :any,   :expected => 'cities_power_up'
  test_next_phase 'cities_power_up',        :any,   :expected => 'resource_replenishment'
  test_next_phase 'resource_replenishment', :any,   :expected => 'market_bureaucracy'
  test_next_phase 'market_bureaucracy',     :any,   :expected => 'turn_order'

  test 'step 3 after auction phase' do
    game = games(:auction_step_3_revealed)
    game.players.first!.purchase_card game.cards.market.first, 1

    assert_difference 'game.step' do
      game.next_phase!
    end

    assert_equal 3, game.step
  end

  test 'step 3 after building phase' do
    game = games(:building_step_3_revealed)

    assert_difference 'game.step' do
      game.next_phase!
    end

    assert_equal 3, game.step
  end

  test 'shuffle draw deck' do
    game = games(:shuffle_draw_deck)
    assert_equal (11..50).to_a, game.cards.draw_deck.pluck(:number)

    game.cards.draw_deck.shuffle!

    refute_equal (11..50).to_a, game.cards.draw_deck.pluck(:number)
    assert_equal (11..50).to_a, game.cards.draw_deck.pluck(:number).sort
  end

  test '#step_3! removes step_3 Card from game' do
    game = games(:start_step_3)

    game.step_3!

    refute_predicate game.cards.step_3.first, :in_play?
  end

end

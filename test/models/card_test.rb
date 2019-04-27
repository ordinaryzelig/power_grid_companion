require 'test_helper'

class CardTest < ActiveSupport::TestCase

  test 'setup' do
    game = games(:card_setup)

    Card.setup game

    assert_equal (3..10).to_a, game.cards.first(8).map(&:number)
    assert_equal 13, game.cards[8].number
    assert_predicate game.cards.last, :step_3
  end

  test '#spike! puts card at bottom of deck' do
    game = games(:card_spike)
    assert_equal [
      {'position' => 0, 'number' => 10},
      {'position' => 1, 'number' => 11},
      {'position' => 2, 'number' => 12},
    ], game.cards.map { |card| card.attributes.slice('position', 'number') }

    game.cards[0].spike!

    assert_equal [
      {'position' => 0, 'number' => 11},
      {'position' => 1, 'number' => 12},
      {'position' => 2, 'number' => 10},
    ], game.cards.map { |card| card.attributes.slice('position', 'number') }
  end

end

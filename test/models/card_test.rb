require 'test_helper'

class CardTest < ActiveSupport::TestCase

  test 'setup' do
    game = games(:card_setup)

    Card.setup game

    assert_equal (3..10).to_a, game.cards.first(8).map(&:number)
    assert_equal 13, game.cards[8].number
    assert_predicate game.cards.last, :step_3
  end

end

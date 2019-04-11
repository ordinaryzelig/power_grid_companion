require 'test_helper'

class TurnOrdersControllerTest < ActionDispatch::IntegrationTest

  test 'updates turn order' do
    game = games(:new_turn_order)
    {
      'red'    => 3,
      'yellow' => 2,
      'green'  => 1,
    }.each do |color, number|
      cards("new_turn_order_#{number}").update!(:player => players("new_turn_order_#{color}"))
    end
    claim_player game.players.first

    post turn_orders_url

    game.reload
    assert_equal %w[red yellow green], game.players.in_turn_order.pluck(:color)
  end

end

require 'test_helper'

class CitiesPowerUpsControllerTest < ActionDispatch::IntegrationTest

  test 'burns resources, pays Player' do
    player = players(:cities_power_up)
    game = player.game
    game.setup

    card = game.cards.find_by!(:number => 3)
    player.cards << card
    card.oils = game.oils.purchasable.limit(3)

    claim_player player

    assert_difference 'player.balance', 22 do
      assert_difference 'card.resources.count', -2 do
        params = {
          :cities_power_up => {
            :cards => [
              {:id => card.id, :oil => 2},
            ],
          },
        }
        post cities_power_ups_url, :params => params
        player.reload
      end
    end

    player.reload
    assert_equal 72, player.balance
    assert_equal 1, card.resources.count
  end

  test '#pass burns no resources, pays Player minimum' do
    game = games(:cities_power_up_pass)
    player = game.players.first
    claim_player player

    assert_difference 'player.balance', 10 do
      post pass_cities_power_ups_url
      player.reload
    end
  end

end

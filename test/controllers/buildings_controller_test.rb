require 'test_helper'

class BuildingsControllerTest < ActionDispatch::IntegrationTest

  test 'adds cities to Player, updates balance' do
    player = players(:building)
    claim_player player

    assert_difference 'player.cities', 2 do
      params = {
        :buildings => [
          {
            :connection_cost => 5,
            :building_cost   => 10,
          },
          {
            :connection_cost => 10,
            :building_cost   => 15,
          },
        ],
      }
      post buildings_url, :params => params
      player.reload
    end

    assert_equal 10, player.balance
  end

  test 'spikes Card if player builds that number of cities' do
    game = games(:spike_card_when_number_of_cities_built)
    claim_player game.players.first!

    assert_difference 'game.cards.market.first.number' do
      params = {
        :buildings => [
          :connection_cost => 0,
          :building_cost   => 10,
        ],
      }
      post buildings_url, :params => params
    end
  end

end

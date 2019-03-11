require 'test_helper'

class BuildingsControllerTest < ActionDispatch::IntegrationTest

  test 'adds cities to Player, updates balance' do
    player = players(:building)
    claim_player player

    assert_difference 'player.cities', 2 do
      params = {
        :buildings => {
          '0' => {
            :connection_cost => 5,
            :building_cost   => 10,
          },
          '1' => {
            :connection_cost => 10,
            :building_cost   => 15,
          },
        },
      }
      post buildings_url, :params => params
      player.reload
    end

    assert_equal 10, player.balance
  end

end

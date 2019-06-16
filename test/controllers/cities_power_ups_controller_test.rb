require 'test_helper'

class CitiesPowerUpsControllerTest < ActionDispatch::IntegrationTest

  test 'burns resources, pays Player' do
    player = players(:cities_power_up)
    game   = player.game
    card   = game.cards.find_by!(:number => 3)
    claim_player player

    assert_difference 'player.cities_power_ups.count' do
      assert_changes 'player.balance', :from => 50, :to => 72 do
        assert_changes 'card.resources.count', :from => 3, :to => 1 do
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
    end

    cities_power_up = player.cities_power_ups.last
    assert_equal 1, cities_power_up.cities
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

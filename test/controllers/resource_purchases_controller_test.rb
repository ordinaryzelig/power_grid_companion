require 'test_helper'

class ResourcePurchasesControllerTest < ActionDispatch::IntegrationTest

  test '#create updates Player balance, stores resources' do
    player = players(:resource_purchase)
    player.game.setup
    claim_player player

    assert_difference 'player.balance', -15 do
      params = {
        :resource_purchase => {
          :oil  => 4,
          :coal => 2,
        },
      }
      post resource_purchases_url, :params => params
      player.reload
    end

    assert_equal 4, player.oils.count
    assert_equal 2, player.coals.count
  end

end

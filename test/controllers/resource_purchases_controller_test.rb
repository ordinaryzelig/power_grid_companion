require 'test_helper'

class ResourcePurchasesControllerTest < ActionDispatch::IntegrationTest

  test '#create updates Player balance, stores resources' do
    player = players(:resource_purchase)
    player.game.setup
    claim_player player

    coal_card = player.game.cards.find_by!(:number => 4)
    player.purchase_card coal_card, 4

    coal_oil_card = player.game.cards.find_by!(:number => 5)
    player.purchase_card coal_oil_card, 5

    assert_difference 'player.balance', -15 do
      params = {
        :resource_purchase => {
          :coal => 2,
          :oil  => 4,
        },
      }
      post resource_purchases_url, :params => params
      player.reload
    end

    assert_equal 2, coal_card.coals.count
    assert_equal 4, coal_oil_card.oils.count
  end

  test '#pass' do
    player = players(:resource_purchase_pass_0)
    claim_player player

    post pass_resource_purchases_url

    refute_includes player.game.phase_players.ids, player.id
  end

end

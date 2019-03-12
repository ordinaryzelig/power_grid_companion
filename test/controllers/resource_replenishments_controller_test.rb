require 'test_helper'

class ResourceReplenishmentsControllerTest < ActionDispatch::IntegrationTest

  test 'replenishes Resource market' do
    game = games(:resource_replenishment)
    game.setup
    player = game.players.first!
    claim_player player

    Resource.kinds.keys.each do |kind|
      card = game.cards.send(kind).first
      player.purchase_card card, card.number
      game.resources_of_kind(kind).purchasable.limit(1).each do |resource|
        player.purchase_resource(resource)
        resource.return_to_general_supply
      end
    end

    post resource_replenishments_url

    assert_equal 24, game.coals.purchasable.count
    assert_equal 21, game.oils.purchasable.count
    assert_equal  3, game.urania.purchasable.count
    assert_equal  8, game.trashes.purchasable.count
  end

end

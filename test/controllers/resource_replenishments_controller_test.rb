require 'test_helper'

class ResourceReplenishmentsControllerTest < ActionDispatch::IntegrationTest

  test 'replenishes Resource market' do
    game = games(:resource_replenishment)
    game.setup
    claim_player game.players.first!

    Resource.kinds.keys.each do |kind|
      game.resources_of_kind(kind).purchasable.limit(1).each do |resource|
        resource.owner.update!(:occupied => false)
        resource.update!(:owner => nil)
      end
    end

    post resource_replenishments_url

    assert_equal 24, game.coals.purchasable.count
    assert_equal 21, game.oils.purchasable.count
    assert_equal  3, game.urania.purchasable.count
    assert_equal  8, game.trashes.purchasable.count
  end

end

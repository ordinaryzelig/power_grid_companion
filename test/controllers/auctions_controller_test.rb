require 'test_helper'

class AuctionsControllerTest < ActionDispatch::IntegrationTest

  test 'creates Action record with Power Plant card' do
    player = players(:auction_creator)
    game = player.game
    game.setup
    claim_player player
    card = game.cards.find_by(:number => 3)

    assert_difference 'game.auctions.count' do
      post auctions_url, :params => {
        :auction => {
          :card_id => card.id,
        }
      }
      game.reload
    end

    auction = game.auctions.last
    assert_equal card, auction.card
    assert_equal game.players.in_turn_order.map(&:id), auction.bidder_ids
  end

  test 'only bidder buys Card' do
    player = players(:only_bidder)
    game = player.game
    game.setup
    assert_equal 1, game.players.size
    claim_player player
    card = game.cards.find_by(:number => 3)

    post auctions_url, :params => {
      :auction => {
        :card_id => card.id,
      }
    }
    game.reload

    player.reload
    card.reload
    assert_equal player, card.player
    assert_equal 47, player.balance
  end

  test 'bid with multiple potential buyers' do
    auction = auctions(:multiple_bidders)
    card = cards(:multiple_bidders)
    assert_equal [3, 1, 2], auction.bidders.map(&:turn_order)
    claim_player auction.bidders.first

    assert_difference 'auction.price' do
      post bid_auction_url(auction)
      auction.reload
    end

    assert_equal [1, 2, 3], auction.bidders.map(&:turn_order)
    assert_equal card.number + 1, auction.price
  end

end

require 'test_helper'

class AuctionsControllerTest < ActionDispatch::IntegrationTest

  test 'creates Auction record with Power Plant card' do
    player = players(:auction_creator)
    game = player.game
    claim_player player
    card = cards(:auction_creator)

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
    bidder_ids = [
      players(:auction_participator_0).id,
      players(:auction_participator_1).id,
      players(:auction_creator).id, # Bid first, so is last.
    ]
    assert_equal bidder_ids, auction.bidder_ids
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
  end

  test 'passing removes bidder' do
    auction = auctions(:multiple_bidders)
    card = cards(:multiple_bidders)
    assert_equal [3, 1, 2], auction.bidders.map(&:turn_order)
    claim_player auction.bidders.first

    assert_difference 'auction.price', 0 do
      post pass_auction_url(auction)
      auction.reload
    end

    assert_equal [1, 2], auction.bidders.map(&:turn_order)

    claim_player auction.bidders.first
    assert_difference 'auction.price', 0 do
      post pass_auction_url(auction)
      auction.reload
    end
  end

  test 'claiming Auction sells to bidder' do
    auction = auctions(:claim_auction)
    card = cards(:claim_auction_0)
    player = players(:claim_auction_0)
    claim_player player

    assert_difference 'player.balance', -auction.price do
      post claim_auction_url(auction)
      player.reload
    end

    card.reload
    assert_equal player, card.player
    assert_equal 47, player.balance

    refute_includes auction.game.phase_player_ids, player.id

    assert_redirected_to new_auction_url
  end

  test 'claiming Auction requires bidder to replace Card if they have 3 Cards' do
    auction = auctions(:claim_auction_replace)
    card_to_replace = cards(:claim_auction_replace_3)
    player = players(:claim_auction_replace_0)
    assert_includes player.cards, card_to_replace
    claim_player player

    post claim_auction_url(auction), :params => {:card_to_replace_id => card_to_replace.id}

    card_to_replace.reload
    refute card_to_replace.in_play
  end

  test 'skipping Auction removes Player from phase' do
    game = games(:skip_auction)
    players = 3.times.map { |idx| players("skip_auction_#{idx}") }
    player = players.first
    claim_player player

    post skip_auctions_url

    game.reload
    assert_equal players.without(player).map(&:id), game.phase_player_ids
  end

  test 'reveal step 3 card in middle of auction phase leaves step 3 in the market, does not trigger step 3' do
    game = games(:auction_step_3_revealed)
    claim_player players(:auction_step_3_revealed_0)
    auction = auctions(:auction_step_3_revealed_0)

    assert_difference 'game.cards.power_plants.market.size', -1 do
      post claim_auction_url(auction)
    end

    game.reload
    assert_equal 2, game.step

    assert_equal game.cards.step_3.first!, game.cards.future_market.last
    assert_equal 8, game.cards.market.count
  end

  test 'redirects to step 3 after Auction phase if step_3 Card revealed' do
    game = games(:auction_step_3_revealed)

    game.players.each_with_index do |player, idx|
      claim_player player
      auction = auctions("auction_step_3_revealed_#{idx}")
      post claim_auction_url(auction)
    end

    assert_redirected_to step3s_url
  end

  test 'all Players passing removes lowest card from Game' do
    game = games(:auction_all_players_pass)
    lowest_card = game.cards.market.first

    game.players.each do |player|
      claim_player player
      post skip_auctions_url
    end

    lowest_card.reload
    refute lowest_card.in_play
  end

end

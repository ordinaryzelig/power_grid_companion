require 'test_helper'

class MarketBureaucraciesControllerTest < ActionDispatch::IntegrationTest

  test '#create spikes highest card, replaces it with a new one' do
    game = games(:market_bureaucracy)
    claim_player game.players.first

    post market_bureaucracies_url

    spiked_card = cards(:market_bureaucracy_spiked)
    drawn_card = cards(:market_bureaucracy_drawn)

    assert_select ".last_spiked #card_#{spiked_card.id}"
    assert_select ".drawn #card_#{drawn_card.id}"
    assert_select ".power_plant_market #card_#{drawn_card.id}"
  end

  test 'shows step 3 button if step_3 Card drawn' do
    game = games(:market_bureaucracy_step_3_drawn)
    claim_player game.players.first

    post market_bureaucracies_url

    drawn_card = game.cards.last_drawn
    assert_predicate drawn_card, :step_3?
    assert_select ".drawn #card_#{drawn_card.id}"

    assert_select "a#start_step_3"
  end

end

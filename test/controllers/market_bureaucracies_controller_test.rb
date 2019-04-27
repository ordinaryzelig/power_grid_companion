require 'test_helper'

class MarketBureaucraciesControllerTest < ActionDispatch::IntegrationTest

  test '#create spikes highest card, replaces it with a new one' do
    game = games(:market_bureaucracy)
    claim_player game.players.first

    post market_bureaucracies_url

    spiked_card = cards(:market_bureaucracy_spiked)
    drawn_card = cards(:market_bureaucracy_drawn)

    assert_select ".last_spiked #card_#{spiked_card.id}"
    assert_select ".power_plant_market #card_#{drawn_card.id}"
  end

end

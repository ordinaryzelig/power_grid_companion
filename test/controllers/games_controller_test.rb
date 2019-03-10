require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest

  test 'create new Game randomizes turn order' do
    colors = [:red, :purple, :black, :green]
    assert_difference 'Game.count' do
      params = {
        :game => {
          :players_attributes => colors.map do |color|
            {
              :name  => "Player #{color}",
              :color => color,
            }
          end,
        },
      }
      post games_url, :params => params
    end

    game = Game.last
    assert_equal colors.map(&:to_s).sort, game.players.map(&:color).sort
    assert_equal (1..colors.size).to_a, game.players.map(&:turn_order).sort

    refute_empty game.resources
    refute_empty game.resource_market_spaces
    refute_empty game.cards
  end

end

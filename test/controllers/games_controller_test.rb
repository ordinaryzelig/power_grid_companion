require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest

  test 'create new Game randomizes turn order' do
    colors = [:red, :purple, :black, :green]
    assert_difference 'Game.count' do
      params = {
        :game => {
          :players_attributes => colors.each_with_index.map do |color, idx|
            {
              :name          => "Player #{color}",
              :color         => color,
              :seat_position => idx + 1,
            }
          end,
        },
      }
      post games_url, :params => params
    end

    game = Game.last
    assert_equal 'auction', game.phase
    assert_equal colors.map(&:to_s).sort, game.players.map(&:color).sort
    assert_equal (0...colors.size).to_a, game.players.map(&:turn_order).sort

    refute_empty game.resources
    refute_empty game.resource_market_spaces
    refute_empty game.cards
  end

  test '#join shows game and players to claim' do
    game = games(:join)

    get join_game_url(game)

    assert_response :ok

    offline_player_button = css_select("#player_#{players(:join_offline).id} input[type=submit]").first
    refute offline_player_button[:disabled]

    online_player_button = css_select("#player_#{players(:join_online).id} input[type=submit]").first
    assert online_player_button[:disabled]
  end

end

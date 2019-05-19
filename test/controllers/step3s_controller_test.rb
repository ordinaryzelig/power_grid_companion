require 'test_helper'

class Step3sControllerTest < ActionDispatch::IntegrationTest

  test '#create starts step 3' do
    game = games(:start_step_3)
    claim_player game.players.first

    post step3s_url

    game.reload
    assert_equal 3, game.step
  end

end

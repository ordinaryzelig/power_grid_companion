ActionDispatch::IntegrationTest.include(
  Module.new do

    def claim_player(player)
      post claim_player_url(player)
    end

  end
)

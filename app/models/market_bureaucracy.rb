class MarketBureaucracy

  def initialize(game)
    @game = game
  end

  def save!
    @game.cards.next_to_spike.spike!
  end

end

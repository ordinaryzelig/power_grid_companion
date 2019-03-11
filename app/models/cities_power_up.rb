class CitiesPowerUp

  PAYMENTS = {
     0 => 10,
     1 => 22,
     2 => 33,
     3 => 44,
     4 => 54,
     5 => 64,
     6 => 73,
     7 => 82,
     8 => 90,
     9 => 98,
    10 => 105,
    11 => 112,
    12 => 118,
    13 => 124,
    14 => 129,
    15 => 134,
    16 => 138,
    17 => 142,
    18 => 145,
    19 => 148,
    20 => 150,
  }

  def initialize(player, params)
    @player = player
    @params = params
    @cards  = []
  end

  def save!
    cards_atts.each(&method(:burn_resources))
    payout
    @player.save!
  end

private

  def cards_atts
    @params.fetch(:cards)
  end

  def burn_resources(card_atts)
    card = @player.cards.find(card_atts.fetch(:id))
    @cards << card
    card_atts.except(:id).each do |kind, count|
      card.resources_of_kind(kind).limit(count).return_to_general_supply
    end
  end

  def payout
    @player.balance += PAYMENTS.fetch(powered_cities)
  end

  def powered_cities
    [@player.cities, @cards.sum(&:cities)].min
  end

end

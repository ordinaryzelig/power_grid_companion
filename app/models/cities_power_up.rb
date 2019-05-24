class CitiesPowerUp < ApplicationRecord

  belongs_to :player

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

  class << self

    def pass!
      cities_power_up = new(
        :cards => []
      )
      cities_power_up.save!
      cities_power_up
    end

  end

  before_validation :assign_round
  before_create :burn_resources
  before_create :assign_cities
  after_create :payout

  def cards=(cards_atts)
    @cards_atts = cards_atts
  end

private

  def cards
    @cards ||= []
  end

  def burn_resources
    @cards_atts.each do |card_atts|
      card = player.cards.find(card_atts.fetch(:id))
      cards << card
      card_atts.except(:id).each do |kind, count|
        card.resources_of_kind(kind).limit(count).return_to_general_supply
      end
    end
  end

  def payout
    player.update!(:balance => player.balance + PAYMENTS.fetch(cities))
  end

  def assign_round
    self.round = player.game.round
  end

  def assign_cities
    self.cities = [player.cities, cards.sum(&:cities)].min
  end

end

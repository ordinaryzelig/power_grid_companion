class Buildings

  def initialize(player, params)
    @player = player
    @params = params
  end

  def save!
    @player.cities += cities
    @player.balance -= connection_costs + building_costs
    @player.save!

    @player.game.cards.market.where('number <= ?', @player.cities).each do |card|
      card.spike!
    end
  end

  def cities
    buildings_atts.size
  end

  def connection_costs
    buildings_atts.sum do |atts|
      Integer(atts.fetch(:connection_cost))
    end
  end

  def building_costs
    buildings_atts.sum do |atts|
      Integer(atts.fetch(:building_cost))
    end
  end

  def buildings_atts
    @buildings_atts ||= @params.fetch(:buildings)
  end

end

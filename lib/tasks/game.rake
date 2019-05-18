task :new_game => :environment do |t, args|
  g = Game.create!(
    :step => 1,
    :players_attributes => Player.colors.keys.shuffle.each_with_index.map do |color, idx|
      {
        :name => color,
        :color => color,
        :seat_position => idx,
      }
    end,
  )
  puts "Game #{Rails.application.routes.url_helpers.game_path(g).inspect}"
  ap "Players #{g.players.in_turn_order.ids.join(', ')}"
end

task :random_cards, [:game_token] => :environment do |t, args|
  game = Game.find_by!(:token => args.game_token)
  cards = game.cards.power_plants.to_a
  cards.shuffle
  game.players.each do |player|
    player.cards = (1..3).to_a.sample.times.map do |idx|
      card = cards.pop
      card
    end
    player.cards.not_renewable.each do |card|
      num = (1..card.resources_required * 2).to_a.sample
      ResourcePurchase.new(player, {card.selected_kinds.sample => num}, :skip_authorization => true).save!
    end
  end
end

task :step_3, [:game_token] => :environment do |t, args|
  game = Game.find_by!(:token => args.game_token)
  game.update!(:step => 2)

  step_3 = game.cards.step_3.first!
  last_market_card = game.cards.market.to_a.last
  top_of_draw_deck = game.cards.draw_deck.first!

  if last_market_card.position < step_3.position
    game.cards.where('position >= ?', top_of_draw_deck.position).update_all('position = position + 1')
    step_3.update!(:position => last_market_card.position + 1)
  else
    raise
    #step_3.update!(:position => top_of_draw_deck.position)
    #top_of_draw_deck.update!(:position => step_3.position)
  end
end

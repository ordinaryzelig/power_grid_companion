task :new_game => :environment do
  g = Game.create!(
    :step => 1,
    :players_attributes => Player.colors.keys.map do |color|
      {
        :name => color,
        :color => color,
      }
    end,
  )
  ap "Game #{g.id}"
  ap "Players #{g.players.in_turn_order.ids.join(', ')}"
end

task :random_cards, [:game_id] => :environment do |t, args|
  game = Game.find(args.game_id)
  cards = game.cards.power_plants.to_a
  cards.shuffle
  game.players.each do |player|
    player.cards = (1..3).to_a.sample.times.map do |idx|
      cards.pop
    end
  end
end

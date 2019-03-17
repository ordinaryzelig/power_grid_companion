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

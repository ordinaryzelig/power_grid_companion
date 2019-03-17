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
  ap g.id
end

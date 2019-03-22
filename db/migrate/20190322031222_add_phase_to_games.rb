class AddPhaseToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :phase, :integer, :default => 1
  end
end

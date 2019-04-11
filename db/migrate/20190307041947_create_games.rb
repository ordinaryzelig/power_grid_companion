class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :token, :null => false
      t.integer :step, :null => false, :default => 1
      t.integer :round, :null => false, :default => 1
      t.integer :phase, :default => 1
      t.integer :phase_player_ids, :array => true

      t.timestamps
    end
    add_index :games, :token, :unique => true
  end
end

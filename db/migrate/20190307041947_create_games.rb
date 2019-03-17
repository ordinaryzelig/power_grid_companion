class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :token, :null => false
      t.integer :step, :null => false, :default => 1
      t.belongs_to :current_player
      t.timestamps
    end
    add_index :games, :token, :unique => true
  end
end

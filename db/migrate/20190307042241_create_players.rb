class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.belongs_to :game, foreign_key: true, :null => false
      t.string :name, :null => false
      t.integer :color, :null => false
      t.integer :balance, :null => false, :default => 50
      t.integer :cities, :null => false, :default => 0
      t.integer :seat_position, :null => false
      t.integer :turn_order, :null => false
      t.boolean :online, :null => false, :default => false

      t.timestamps
    end
  end
end

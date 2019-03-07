class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.belongs_to :game, foreign_key: true, :null => false
      t.string :name, :null => false
      t.integer :color, :null => false
      t.integer :balance, :null => false

      t.timestamps
    end
  end
end

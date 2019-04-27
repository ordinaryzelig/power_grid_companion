class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.belongs_to :game, foreign_key: true, :null => true
      t.integer :number
      t.integer :kinds # flag_shih_tzu
      t.integer :resources_required
      t.integer :cities
      t.belongs_to :player, foreign_key: true
      t.integer :position, :null => false

      t.timestamps
    end
    add_index :cards, [:game_id, :number], :unique => true
  end
end

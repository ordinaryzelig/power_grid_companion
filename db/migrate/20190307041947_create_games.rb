class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :token, :null => false
      t.timestamps
    end
    add_index :games, :token, :unique => true
  end
end

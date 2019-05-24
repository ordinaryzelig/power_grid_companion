class CreateCitiesPowerUps < ActiveRecord::Migration[5.2]
  def change
    create_table :cities_power_ups do |t|
      t.belongs_to :player, foreign_key: true, :null => false
      t.integer :round, :null => false
      t.integer :cities, :null => false
    end
  end
end

class CreateResources < ActiveRecord::Migration[5.2]
  def change
    create_table :resources do |t|
      t.belongs_to :game, foreign_key: true, :null => false
      t.integer :kind, :null => false
      t.belongs_to :resource_market_space
      t.belongs_to :player

      t.timestamps
    end
  end
end

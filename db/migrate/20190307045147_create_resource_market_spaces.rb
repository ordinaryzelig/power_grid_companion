class CreateResourceMarketSpaces < ActiveRecord::Migration[5.2]
  def change
    create_table :resource_market_spaces do |t|
      t.belongs_to :game, foreign_key: true, :null => false
      t.integer :kind, :null => true
      t.integer :cost, :null => false
      t.boolean :occupied, :null => false, :default => false
    end
  end
end

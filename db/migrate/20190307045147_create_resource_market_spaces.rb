class CreateResourceMarketSpaces < ActiveRecord::Migration[5.2]
  def change
    create_table :resource_market_spaces do |t|
      t.belongs_to :game, foreign_key: true, :null => false
      t.integer :cost
    end
  end
end

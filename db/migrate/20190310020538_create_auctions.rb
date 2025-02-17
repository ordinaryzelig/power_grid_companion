class CreateAuctions < ActiveRecord::Migration[5.2]
  def change
    create_table :auctions do |t|
      t.belongs_to :game, foreign_key: true, :null => false
      t.belongs_to :card, foreign_key: true, :null => false
      t.belongs_to :player, foreign_key: true, :null => false
      t.integer :bidder_ids, :array => true, :null => false
      t.integer :price
      t.integer :round, :null => false

      t.timestamps
    end
  end
end

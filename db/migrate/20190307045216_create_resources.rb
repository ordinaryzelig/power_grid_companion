class CreateResources < ActiveRecord::Migration[5.2]
  def change
    create_table :resources do |t|
      t.belongs_to :game, foreign_key: true, :null => false
      t.integer :kind, :null => false
      t.belongs_to :owner, :polymorphic => true

      t.timestamps
    end
  end
end

class AddPositionToCards < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :position, :integer, :null => false
  end
end

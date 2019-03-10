class AddTurnOrderToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :turn_order, :integer, :null => false
  end
end

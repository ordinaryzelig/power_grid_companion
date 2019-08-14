class ResourceTransfersController < ApplicationController

  def create
    transfer = ResourceTransfer.new(current_player, transfer_params)
    transfer.save!
    player_cards = render(:partial => 'cards/player_cards', :locals => {:player => current_player, :show_resource_transfer_form => true})
    current_game.broadcast_replace "#player_mat_#{current_player.id} .", player_cards
    head :ok
  end

private

  def transfer_params
    params
      .require(:resource_transfer)
      .permit(
        :card_id,
        :resource_ids, # JSON array.
      )
  end

end

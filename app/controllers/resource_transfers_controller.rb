class ResourceTransfersController < ApplicationController

  def new
  end

  def create
    transfer = ResourceTransfer.new(current_player, transfer_params)
    transfer.save!
    player_mat = render(:partial => 'player_mats/player_mat', :locals => {:player => current_player})
    current_game.broadcast_replace "#player_mat_#{current_player.id}", player_mat
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

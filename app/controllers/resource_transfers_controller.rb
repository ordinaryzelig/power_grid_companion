class ResourceTransfersController < ApplicationController

  def create
    transfer = ResourceTransfer.new(current_player, transfer_params)
    transfer.save!
  end

private

  def transfer_params
    params
      .require(:resource_transfer)
      .permit(
        :card_id,
        :resource_ids => [],
      )
  end

end

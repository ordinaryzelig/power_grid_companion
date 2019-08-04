class ResourceTransfersController < ApplicationController

  def new
  end

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
        :resource_ids, # JSON array.
      )
  end

end

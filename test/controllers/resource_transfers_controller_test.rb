require 'test_helper'

class ResourceTransfersControllerTest < ActionDispatch::IntegrationTest

  test 'transfer selected resources to another card' do
    source_card = cards(:transfer_source)
    resource_ids = source_card.resources.ids
    destination_card = cards(:transfer_destination)

    claim_player source_card.player

    params = {
      :resource_transfer => {
        :resource_ids => resource_ids,
        :card_id      => destination_card.id,
      },
    }
    post resource_transfers_url, :params => params

    assert_empty source_card.resources
    assert_equal resource_ids.sort, destination_card.reload.resources.ids.sort
  end

end

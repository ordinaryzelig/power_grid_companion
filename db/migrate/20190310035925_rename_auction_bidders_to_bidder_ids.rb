class RenameAuctionBiddersToBidderIds < ActiveRecord::Migration[5.2]
  def change
    rename_column :auctions, :bidders, :bidder_ids
  end
end

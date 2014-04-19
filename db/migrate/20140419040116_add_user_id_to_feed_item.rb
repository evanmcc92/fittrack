class AddUserIdToFeedItem < ActiveRecord::Migration
  def change
    add_reference :feed_items, :user_id, index: true
  end
end

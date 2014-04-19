class AddUserIdToFeedItem < ActiveRecord::Migration
  def change
    add_reference :feed_items, :user, index: true
  end
end

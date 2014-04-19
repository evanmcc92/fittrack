class CreateFeedItems < ActiveRecord::Migration
  def change
    create_table :feed_items do |t|
      t.string :type_id, index: true
      t.string :type_name

      t.timestamps
    end
  end
end

class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :model_name, index: true
      t.integer :model_id, index: true
      t.references :user, index: true
      t.references :wo_set, index: true
      t.string :content

      t.timestamps
    end
  end
end

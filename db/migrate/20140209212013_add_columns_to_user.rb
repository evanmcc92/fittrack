class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :weight, :string
    add_column :users, :height, :string
    add_column :users, :bio, :string
  end
end

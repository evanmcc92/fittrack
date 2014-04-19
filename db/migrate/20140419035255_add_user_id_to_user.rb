class AddUserIdToUser < ActiveRecord::Migration
  def change
    add_reference :users, :user_id, index: true
  end
end

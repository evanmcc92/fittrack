class AddAgeToUser < ActiveRecord::Migration
  def change
    add_column :users, :measurement_system, :string
  end
end

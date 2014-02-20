class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.references :exercise, index: true
      t.references :user, index: true
      t.string :weight
      t.string :distance
      t.string :time

      t.timestamps
    end
  end
end

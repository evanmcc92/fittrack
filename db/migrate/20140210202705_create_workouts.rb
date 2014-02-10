class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.references :user
      t.references :exercise
      t.string :rep
      t.string :weight
      t.string :time
      t.string :distance

      t.timestamps
    end
  end
end

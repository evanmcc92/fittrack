class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.references :user
      t.references :exercise
      t.references :workoutset

      t.timestamps
    end
  end
end

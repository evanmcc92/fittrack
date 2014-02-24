class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.references :user
      t.references :wo_set

      t.timestamps
    end
  end
end

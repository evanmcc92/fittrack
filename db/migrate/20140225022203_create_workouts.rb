class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.references :user, index: true
      t.references :wo_set, index: true

      t.timestamps
    end
  end
end

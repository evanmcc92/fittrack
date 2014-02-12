class CreateWorkoutSets < ActiveRecord::Migration
  def change
    create_table :workout_sets do |t|
      t.references :user, index: true
      t.references :exercise, index: true
      t.references :workout, index: true
      t.string :rep
      t.string :weight
      t.string :time
      t.string :distance

      t.timestamps
    end
  end
end

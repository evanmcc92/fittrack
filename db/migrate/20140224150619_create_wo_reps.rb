class CreateWoReps < ActiveRecord::Migration
  def change
    create_table :wo_reps do |t|
      t.string :weight
      t.string :time
      t.string :distance
      t.references :wo_set

      t.timestamps
    end
  end
end

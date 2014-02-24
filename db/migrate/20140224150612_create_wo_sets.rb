class CreateWoSets < ActiveRecord::Migration
  def change
    create_table :wo_sets do |t|
      t.references :wo_rep
      t.references :workout
      t.references :exercise

      t.timestamps
    end
  end
end

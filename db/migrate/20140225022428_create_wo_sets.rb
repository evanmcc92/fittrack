class CreateWoSets < ActiveRecord::Migration
  def change
    create_table :wo_sets do |t|
      t.references :workout, index: true
      t.references :exercise, index: true
      t.string :rep
      t.string :weight
      t.string :time
      t.string :distance

      t.timestamps
    end
  end
end

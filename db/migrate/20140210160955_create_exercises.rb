class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :name
      t.string :description
      t.string :image
      t.references :user, index: true

      t.timestamps
    end
  end
end

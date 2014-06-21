class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :content
      t.references :user, index: true

      t.timestamps
    end
  
  end
end

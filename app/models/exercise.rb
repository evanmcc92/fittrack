

class Exercise < ActiveRecord::Base

require 'csv'
	belongs_to :user
	belongs_to :goal
	belongs_to :wo_set
	

	def self.import(file, user_id)
    CSV.foreach(file.path, headers: true) do |row|

      product_hash = row.to_hash # exclude the price field
      exercise = Exercise.find_by(id: product_hash["id"])

      if exercise.nil?
        Exercise.create!(
          :user_id => user_id,
          :id => row[0],
          :name => row[1],
          :description => row[2],
          :category => row[3]
          )
      else
        exercise.update_attributes(
          :name => row[1],
          :description => row[2],
          :category => row[3]
        )
      end # end if !product.nil?
    end
 	end

end

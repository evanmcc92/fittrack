
require 'csv'

class Exercise < ActiveRecord::Base
	belongs_to :user
	belongs_to :goal
	belongs_to :wo_set
	

	def self.import(file, user_id)
    CSV.foreach(file.path, headers: true) do |row|
      record = Exercise.find(row[0])

      if record.id = row[0]
        record.update_attributes(
          :user_id => user_id,
          :name => row[1],
          :description => row[2],
          :category => row[3]
        )
      else
        record.create(
          :user_id => user_id,
          :id => row[0],
          :name => row[1],
          :description => row[2],
          :category => row[3]
        )
      end
    end
 	end

end

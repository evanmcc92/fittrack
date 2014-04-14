
require 'csv'

class Exercise < ActiveRecord::Base
	belongs_to :user
	belongs_to :goal
	belongs_to :wo_set
	

	def self.import(file, user_id)
    CSV.foreach(file.path, headers: true) do |row|
      record = Exercise.where(
        :user_id => user_id,
        :id => row[0],
        :name => row[1],
        :description => row[2],
        :category => row[3]
      ).first_or_create
    end
 	end

end

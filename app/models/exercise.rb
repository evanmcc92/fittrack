class Exercise < ActiveRecord::Base

require 'csv'
	belongs_to :user
	belongs_to :goal
	belongs_to :wo_set

  #pagination
  self.per_page = 25

  def self.search(query)
    if query
      where("name like ? ", "%#{query}%")
    else
      scoped
    end
  end
	

	def self.import(file, user_id)
    CSV.foreach(file.path, headers: true) do |row|

      exercise = Exercise.find_by(id: row[0])

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
      end
    end
 	end

end

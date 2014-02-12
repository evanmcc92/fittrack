class Exercise < ActiveRecord::Base
	belongs_to :user
	belongs_to :workout
	belongs_to :workoutset
end

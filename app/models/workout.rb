class Workout < ActiveRecord::Base
	has_many :exercises
	has_many :workoutsets
	belongs_to :user
end

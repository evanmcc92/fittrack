class WorkoutSet < ActiveRecord::Base
  belongs_to :user
  has_many :exercise
  belongs_to :workout
end

class WoSet < ActiveRecord::Base
	has_many :wo_reps
	belongs_to :workout
end

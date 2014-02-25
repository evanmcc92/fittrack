class Exercise < ActiveRecord::Base
	belongs_to :user
	belongs_to :goal
	belongs_to :wo_set
	
end

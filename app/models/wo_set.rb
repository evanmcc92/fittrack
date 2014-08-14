class WoSet < ActiveRecord::Base
  belongs_to :workout
  belongs_to :challenge
  has_many :exercises
end

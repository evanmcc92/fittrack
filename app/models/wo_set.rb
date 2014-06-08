class WoSet < ActiveRecord::Base
  belongs_to :workout
  has_many :exercises
  #pagination
  self.per_page = 20
end

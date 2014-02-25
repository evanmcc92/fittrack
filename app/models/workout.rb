class Workout < ActiveRecord::Base
  belongs_to :user
  has_many :wo_sets
end

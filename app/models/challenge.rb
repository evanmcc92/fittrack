class Challenge < ActiveRecord::Base
  belongs_to :user
  has_many :wo_sets

  default_scope -> { order('created_at DESC') }
  
  accepts_nested_attributes_for :wo_sets
end

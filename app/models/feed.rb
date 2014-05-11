class Feed < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  belongs_to :workout
  has_many :wo_sets

  accepts_nested_attributes_for :wo_sets

  	def self.from_users_followed_by(user)
	  followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
	  where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
	end
end
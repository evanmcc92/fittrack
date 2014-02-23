class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :exercises
  has_many :goals
  has_many :posts, dependent: :destroy

  #search
	def self.search(query)
      where("name like ? ", "%#{query}%")
	end

	def feed
    	# This is preliminary. See "Following users" for the full implementation.
    	Post.where("user_id = ?", id)
  	end
end

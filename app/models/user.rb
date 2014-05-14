class User < ActiveRecord::Base
  include Likeable::UserMethods
  include Twitter::Autolink
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :exercises
  has_many :goals
  has_many :workouts
  has_many :posts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name:  "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :feeds

  def to_param
    username
  end

  validates :bio, length: { maximum: 255 }

  #pagination
  self.per_page = 15

  #search
	def self.search(query)
      where("name like ? ", "%#{query}%") && where("username like ? ", "%#{query}%")
	end

  #feed work
	def feed
    Feed.from_users_followed_by(self).order('created_at DESC')
  end

  def recent_feeds
    feeds.order('created_at DESC')
  end

  #following
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end
end

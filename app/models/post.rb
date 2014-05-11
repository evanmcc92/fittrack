class Post < ActiveRecord::Base
    
  include Twitter::Autolink


  belongs_to :user
  has_many :feeds
  
  after_create :create_feed

  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  default_scope -> { order('created_at DESC') }

  
  
  # def self.from_users_followed_by(user)
  #   followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
  #   where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
  # end

  private

  def create_feed
    Feed.create(
      model_id: self,
      model_name: "post",
      user_id: self.user_id,
      content: self.content
    )
  end
  
end

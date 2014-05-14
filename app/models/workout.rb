class Workout < ActiveRecord::Base
  belongs_to :user
  has_many :wo_sets
  has_many :feeds

  after_create :create_feed

  accepts_nested_attributes_for :wo_sets

  default_scope -> { order('created_at DESC') }

  def recent_feeds
    feeds.order('created_at DESC')
  end


  private

  def create_feed
    Feed.create(
      model_id: self.id,
      model_name: "workout",
      user_id: self.user_id,
      wo_set_id: wo_set_id
    )
  end
  
end

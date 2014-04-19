class FeedItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates :user_id, presence: true
  validates :type_id, presence: true
  validates :type_name, presence: true

end

class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id, class_name: 'Post'
  has_many :likes, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id

  validates :Name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  
  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
  
end

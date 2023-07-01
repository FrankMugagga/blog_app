class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :likes, class_name: 'Like', foreign_key: 'post_id'
  has_many :comments, class_name: 'Comment', foreign_key: 'post_id'

  validates :title, presence: true, length: { maximum: 250 }

  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_create :update_user_posts_counter

  def five_recent_comments
    comments.includes(:user).order(created_at: :desc).limit(5)
  end

  private

  def update_user_posts_counter
    author.increment!(:posts_counter)
  end
end

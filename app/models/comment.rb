class Comment < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post, class_name: 'Post', foreign_key: 'post_id'
  after_create :update_comment_counter
  after_destroy :decrement_comment_counter

  def update_comment_counter
    post.increment!(:comments_counter)
  end

  def decrement_comment_counter
    post.decrement!(:comments_counter)
  end
end

class Comment < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  belongs_to :post
  after_create :update_comment_counter
  after_destroy :decrement_comment_counter

  def update_comment_counter
    post.update(comments_counter: post.comments.count)
  end

  def decrement_comment_counter
    post.decrement!(:comments_counter)
  end
end

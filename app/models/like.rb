class Like < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post, class_name: 'Post', foreign_key: 'post_id'
  
  after_create :update_like_counter

  private

  def update_like_counter
    post.increment!(:likes_counter)
  end
  
end

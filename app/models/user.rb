=begin
class User < ApplicationRecord
    has_many :posts, foreign_key: :author_id
    has_many :likes
    has_many :comments

    def three_recent_posts
        posts.order(created_at: :desc).limit(3)
    end
end
=end
class User < ApplicationRecord
    has_many :posts, foreign_key: :author_id
  
    def recent_posts
      posts.order(created_at: :desc).limit(3)
    end
  end
  

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(Name: 'Lumbuye', posts_counter: 2) }
  let(:post) { user.posts.create(title: 'Post1', text: 'content 1', comments_counter: 1, likes_counter: 1) }

  describe '#update_comment_counter' do
    it 'updates the comments_counter of the associated post' do
      comment = Comment.create(author_id: user.id, post_id: post.id, text: 'Some comment')

      expect { comment.send(:update_comment_counter) }.to change { post.reload.comments_counter }.by(1)
    end
    it 'decrements the comments_counter of the associated post' do
      comment = Comment.create(post: post, text: 'Some comment')
      expect { comment.decrement_comment_counter }.to change { post.reload.comments_counter }.by(-1)
    end
  end
end

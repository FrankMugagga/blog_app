require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(Name: 'Lumbuye', posts_counter: 2) }

  it "Should return valid if title is blank" do
    post1 = user.posts.create(title: "Post1", text: "content 1", comments_counter: 1, likes_counter: 1)
    expect(post1).to be_valid
  end
  it "Should return invalid if title is blank" do
    post1 = user.posts.create(title: "", text: "content 1", comments_counter: 1, likes_counter: 1)
    expect(post1).to be_invalid
  end

  it 'validates the maximum length' do
    post1 = user.posts.create(title: "a" * 251, text: "content 1", comments_counter: 1, likes_counter: 1)
    expect(post1).to be_invalid
  end

  it 'Should return invalid if comments are less than 0' do
    post1 = user.posts.create(title: "When", text: "content 1", comments_counter: -1, likes_counter: 1)
    expect(post1).to be_invalid
    expect(post1.errors[:comments_counter]).to include('must be greater than or equal to 0')
  end

  it 'Should return invalid if comments are decimal' do
    post1 = user.posts.create(title: "When", text: "content 1", comments_counter: 3.5, likes_counter: 1)
    expect(post1).to be_invalid
  end

  it 'Should return invalid if likes are less than 1' do
    post1 = user.posts.create(title: "When", text: "content 1", comments_counter: 1, likes_counter: -1)
    expect(post1).to be_invalid
    expect(post1.errors[:likes_counter]).to include('must be greater than or equal to 0')
  end

  it 'Should return invalid if likes are decimal' do
    post1 = user.posts.create(title: "When", text: "content 1", comments_counter: 3.5, likes_counter: 1)
    expect(post1).to be_invalid
  end
  it 'Should return five recent comments' do
    user = User.create(Name: 'Lumbuye', posts_counter: 2)
    post1 = user.posts.create(title: 'When', text: "'ontent 1', comments_counter: 3, likes_counter: 1)

    comment1 = post1.comments.create(author_id: user.id, post_id: post1, text: 'Waaallala', created_at: 1.day.ago)
    comment2 = post1.comments.create(author_id: user.id, post_id: post1, text: 'Waaallala', created_at: 2.days.ago)
    comment3 = post1.comments.create(author_id: user.id, text: 'Waaallala', created_at: 3.days.ago)
    comment4 = post1.comments.create(author_id: user.id, text: 'Waaallala', created_at: 4.days.ago)
    comment5 = post1.comments.create(author_id: user.id, post_id: post1, text: 'Waaallala', created_at: 5.days.ago)

    five_recent_comments = post1.five_recent_comments
    expect(five_recent_comments).to eq([comment1, comment2, comment3, comment4, comment5])
  end
  describe '#update_user_posts_counter' do
    it 'increments the author\'s posts_counter' do
      post = user.posts.create(title: 'Post1', text: 'ontent 1', comments_counter: 1, likes_counter: 1)

      expect { post.send(:update_user_posts_counter) }.to change { user.reload.posts_counter }.by(1)
    end
  end
end

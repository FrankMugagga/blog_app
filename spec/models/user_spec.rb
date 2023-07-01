require 'rails_helper'

RSpec.describe User, type: :model do
  it 'Should be valid with a name' do
    user = User.new(Name: 'Lumbuye', posts_counter: 2)
    expect(user).to be_valid
  end

  it 'Should be invalid without a name' do
    user = User.new(posts_counter: 2)
    expect(user).to be_invalid
    expect(user.errors[:Name]).to include("can't be blank")
  end
  it 'Sould be invalid if less than zero' do
    user = User.new(Name: 'Me', posts_counter: -1)
    expect(user).to be_invalid
    expect(user.errors[:posts_counter]).to include('must be greater than or equal to 0')
  end
  it 'Should return only integers' do
    user = User.new(Name: 'Me', posts_counter: 1.6)
    expect(user).to be_invalid
    expect(user.errors[:posts_counter]).to include('must be an integer')
  end

  it 'Should return the most recent post' do
    user = User.create(Name: 'Lumbuye', posts_counter: 2)

    post2 = user.posts.create(title: 'Post2', text: 'content 2', comments_counter: 2, likes_counter: 2)
    post3 = user.posts.create(title: 'Post3', text: 'content 3', comments_counter: 3, likes_counter: 3)
    post4 = user.posts.create(title: 'Post4', text: 'content 4', comments_counter: 4, likes_counter: 4)

    recent_posts = user.recent_posts

    expect(recent_posts).to eq([post4, post3, post2])
    expect(recent_posts.length).to eq 3
  end
end

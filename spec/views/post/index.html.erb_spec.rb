require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

RSpec.describe 'post/index.html.erb', type: :view do
  include Capybara::DSL

  before do
    @user = User.create(Name: 'John Doe', Photo: 'example.jpg', Bio: 'From Guinea', posts_counter: 3)
    @post = Post.create(author_id: @user.id, title: 'Test Post', text: 'text body', comments_counter: 1,
                        likes_counter: 1)
    @comment1 = Comment.create(author_id: @user.id, post_id: @post.id, text: 'Comment1')
    @comment2 = Comment.create(author_id: @user.id, post_id: @post.id, text: 'Comment2')
  end

  describe 'Post index test' do
    it "I can see the user's profile picture." do
      visit user_posts_path(@user)
      page.has_content?(@user.Photo)
    end

    it "I can see the user's username." do
      visit user_posts_path(@user)
      expect(page).to have_content(@user.Name)
    end

    it 'I can see the number of posts the user has written.' do
      visit user_posts_path(@user)
      expect(page).to have_content(@user.posts_counter)
    end

    it "I can see a post's title." do
      visit user_posts_path(@user)
      expect(page).to have_content(@post.title)
    end

    it "I can see some of the post's body." do
      visit user_posts_path(@user)
      expect(page).to have_content(@post.text)
    end

    it 'I can see the first comments on a post.' do
      visit user_posts_path(@user)
      expect(page).to have_content(@comment1.text)
      expect(page).to have_content(@comment2.text)
    end
  end

  it 'I can see how many comments a post has.' do
    visit user_posts_path(@user)
    expect(page).to have_content(@post.comments_counter)
  end

  it 'I can see how many likes a post has.' do
    visit user_posts_path(@user)
    expect(page).to have_content(@post.likes_counter)
  end

  it 'I can see a section for pagination if there are more posts than fit on the view.' do
      visit user_posts_path(@user)
      expect(page).to have_button('PAGINATION')
    end

  it "When I click on a post, it redirects me to that post's show page." do
    visit user_posts_path(@user)
    click_on 'text body'
    visit user_post_path(@user.id, @post.id)
    page.has_content?(@post.title)
  end
end

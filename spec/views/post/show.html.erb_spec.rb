require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

RSpec.describe 'post/show.html.erb', type: :view do
  include Capybara::DSL
  before do
    @user = User.create(Name: 'John Doe', Photo: 'example.jpg', Bio: 'From Guinea', posts_counter: 3)
    @post = Post.create(author_id: @user.id, title: 'Test Post', text: 'text body', comments_counter: 1, likes_counter: 1)
    @comment1 = Comment.create(author_id: @user.id, post_id: @post.id, text: 'Comment1')
    @comment2 = Comment.create(author_id: @user.id, post_id: @post.id, text: 'Comment2')
  end

  describe 'Post show test' do
    it "I can see the post's title." do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content(@post.title)
    end

    it 'I can see who wrote the post.' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content(@post.author.Name)
    end

    it 'I can see how many comments it has.' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content(@post.comments_counter)
    end

    it 'I can see how many likes it has.' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content(@post.likes_counter)
    end

    it 'I can see the post body.' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content(@post.text)
    end

    it 'I can see the username of each commentor.' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content(@comment1.user.Name)
    end

    it 'I can see the comment each commentor left.' do
      visit user_post_path(@user.id, @post.id)
      page.has_content?(@comment1.text)
    end
  end
end

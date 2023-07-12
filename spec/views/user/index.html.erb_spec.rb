require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

RSpec.describe 'User', type: :view do
  include Capybara::DSL
  before do
    @user = User.create(Name: 'Jot', Photo: 'john.png', Bio: 'from Hungary', posts_counter: 1)
    @user1 = User.create(Name: 'Johnt', Photo: 'john.png', Bio: 'from Hungary', posts_counter: 1)
    @user2 = User.create(Name: 'Dee', Photo: 'dee.png', Bio: 'uganda', posts_counter: 2)
    @post1 = @user1.posts.create(text: 'Post 1', comments_counter: 0, likes_counter: 0)
    @post = Post.create(author_id: @user.id, title: 'Test Post', text: 'text body', comments_counter: 1,
                        likes_counter: 1)
  end

  describe 'index page' do
    it 'Display the user name for all users' do
      visit users_path
      expect(page).to have_content(@user1.Name)
      page.has_content?(@user2.Name)
    end

    it 'Display profile pic of each user' do
      visit users_path
      page.has_content?(@user1.Photo)
      expect(page).to have_css("img[src*='john.png']")
    end

    it 'Display the number of posts a user has written' do
      visit users_path
      page.has_content?(@user1.posts_counter)
      expect(page).to have_content(@user2.posts_counter)
    end

    it 'Redirects to the user show page when a user is clikced' do
      visit users_path
      click_link @user1.Name
      expect(page).to have_current_path(user_path(@user1))
    end
  end
end

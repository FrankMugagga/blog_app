require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    before do
      user = User.create(Name: 'Lumbuye', posts_counter: 2)
      get "/users/#{user.id}/posts"
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'It returns the correct template' do
      expect(response).to render_template(:index)
    end

    it 'It returns place holder from the body' do
      expect(response.body).to include('All posts')
    end
  end

  describe 'GET /show' do
    before do
      user = User.create(Name: 'Lumbuye', posts_counter: 2)
      post = user.posts.create(title: 'Post', text: 'content', comments_counter: 2, likes_counter: 2)
      get "/users/#{user.id}/posts/#{post.id}"
    end

    it 'Returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'Renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'Returns the expected place holder' do
      expect(response.body).to include('Post details')
    end
  end
end

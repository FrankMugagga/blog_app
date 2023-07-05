require 'rails_helper'

RSpec.describe 'Users', type: :request do

  describe 'GET /index' do

    before do
      get '/user/index'
    end

    it 'returns http success' do      
      expect(response).to have_http_status(:success)      
    end

    it 'renders the index template ' do
      expect(response).to render_template(:index)
    end

    it 'Body includes correct place holder ' do
      expect(response.body).to include('List of all users')
    end
  end

  describe 'GET /show' do
    before do
      user = User.create(Name: 'Lumbuye', posts_counter: 2)
      get "/user/show", params: { id: user.id } 
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the correct template' do
      expect(response).to render_template(:show)
    end

    it 'returns right place holder' do
      expect(response.body).to include('User profile')
    end
  end
  
end

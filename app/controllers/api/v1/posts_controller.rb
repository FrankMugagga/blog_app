class Api::V1::PostsController < ApplicationController
    def index
        user = User.find(params[:user_id])
        posts = user.posts

        if posts.present?
            render json: { success: true, message: 'Posts retrieved successfully', posts: posts  }
        else
            render json: { success: false, message: 'No posts found for the user', status: :not_found }
        end
        
    rescue ActiveRecord::RecordNotFound
        render json: { error: 'User not found', status: :not_found }
    end
end
class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @post = @user.posts

    render :index
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])

    render :show
  end
end

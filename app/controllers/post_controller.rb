class PostController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @post = @user.Post

    render :index
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])

    render :show
  end
end

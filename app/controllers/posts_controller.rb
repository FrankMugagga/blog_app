class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
    @post = Post.includes(:author, :comments).where(author_id: params[:user_id])

    render :index
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])

    if @post
      @comment = Comment.new
      @like = Like.new
    end

    @comment = Comment.new
    @comments = @post.comments

    render :show
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save

      redirect_to user_posts_path, notice: 'Post saved successfully'
    else
      flash.now[:error] = @post.errors.full_messages.to_sentence
      render :new
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])

    if @post.destroy
      redirect_to user_posts_path(current_user, @post), notice: 'Post was successfully deleted'
    else
      p @post.errors.full_messages
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end

class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @post = @user.posts

    render :index
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new

    render :show
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    # title = post_params[:title]
    # text = post_params[:text]
    # posts = Post.new(author_id: current_user.id, title: title, text: text, comments_counter: 0, likes_counter: 0 )
    @post = current_user.posts.build(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      # redirect_to user_posts_path(current_user, @post), notice: 'Post created successfully'
      redirect_to user_posts_path, notice: 'Post saved successfully'
    else
      flash.now[:error] = @post.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end

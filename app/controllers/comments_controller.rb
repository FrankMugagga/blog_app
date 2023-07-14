class CommentsController < ApplicationController
  before_action :set_user_and_post
  load_and_authorize_resource

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.author_id = current_user.id

    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  def destroy

    @comment = current_user.comments.find(params[:id])

    if @comment.destroy
      redirect_to user_posts_path(current_user, @post), notice: "Post was successfully deleted"
    else
     p @comment.errors.full_messages
    end
  end

  private

  def set_user_and_post
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end

class Api::V1::CommentsController < ApplicationController
  before_action :set_user_and_post
  load_and_authorize_resource

  def index
    user = User.find(params[:user_id])
    post = user.posts.find(params[:post_id])
    comments = post.comments

    if comments.present?
      render json: { success: true, message: 'Comments retrieved successfully', posts: comments }
    else
      render json: { success: false, message: 'No comments found for the user', status: :not_found }
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User, post, or comments not found' }, status: :not_found
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.author_id = current_user.id

    if @comment.save
      render json: { message: 'Comment was successfully created.' }, status: :created
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user_and_post
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end

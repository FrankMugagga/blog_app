class Api::V1::CommentsController < ApplicationController
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
    user = User.find(params[:user_id])
    post = user.posts.find(params[:post_id])
    comment = post.comments.build(comment_params)
    comment.author_id = current_user.id

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end

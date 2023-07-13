class LikesController < ApplicationController
=begin
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.find_or_initialize_by(author_id: current_user.id)

    if @like.persisted?
      # Like already exists, update it
      @like.update(author_id: current_user.id)
    elsif @like.save
      # New like, save it
      @post.increment!(:likes_counter)
    end

    redirect_to user_post_path(user_id: @user.id, id: @post.id), notice: 'Post successfully liked'
  end
=end
def create
  post = Post.find(params[:id])
  @like = post.likes.new(author: current_user)
  if @like.save
    redirect_to likes_path(current_user, post)
  else
    render :new, status: :unprocessable_entity
  end
end
end

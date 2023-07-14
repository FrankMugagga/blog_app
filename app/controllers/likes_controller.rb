class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    @like = post.likes.new(author: current_user)

    if @like.save
      # post.increment!(:likes_counter)
      redirect_to user_post_path(post.author, post)
    else
      render :new, status: :unprocessable_entity
    end
  end
end

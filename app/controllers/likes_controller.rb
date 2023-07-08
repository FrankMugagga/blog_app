class LikesController < ApplicationController
  def create
    @post = Post.find(params[:id])
    @author_id = params[:author_id]
    @like = @post.likes.new(author_id: current_user.id)

    if @like.persisted?
      # Like already exists, update it
      @like.update_attributes(author_id: current_user.id)
    elsif @like.save
      # New like, save it
      redirect_to "/users/#{author_id}/posts/#{post.id}", notice: 'Post successfully liked'
    end
  end
end

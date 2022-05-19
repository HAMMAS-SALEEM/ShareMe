class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new(user_id: current_user.id, post_id: @post.id)
    if @like.save
      redirect_to user_post_path(user_id: current_user.id, id: @post.id)
      flash[:notice] = 'You have liked a post'
      @post.increment!(:LikesCounter)
    else
      flash[:notice] = 'You have not liked a post'
    end
  end
end

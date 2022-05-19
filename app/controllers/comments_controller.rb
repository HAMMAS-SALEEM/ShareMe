class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(Text: comment_params[:Text], user_id: current_user.id, post_id: @post.id)
    if @comment.save
      flash[:notice] = 'Comment is created successfully'
      @post.increment!(:CommentsCounter)
      redirect_to user_posts_url
    else
      flash[:notice] = 'Comment is not created'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:Text)
  end
end

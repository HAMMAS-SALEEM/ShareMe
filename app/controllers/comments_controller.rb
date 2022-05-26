class CommentsController < ApplicationController
  load_and_authorize_resource nested: :post

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(Text: comment_params[:Text], user_id: current_user.id, post_id: @post.id)
    if @comment.save
      flash[:success] = 'Comment is created successfully'
      @post.increment!(:CommentsCounter)
      redirect_to user_posts_url
    else
      flash[:error] = 'Comment is not created'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id]).destroy
    redirect_to user_post_path(@user, @post)
    @post.decrement!(:CommentsCounter)
  end

  private

  def comment_params
    params.require(:comment).permit(:Text)
  end
end

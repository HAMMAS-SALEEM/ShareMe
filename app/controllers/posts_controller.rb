class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def new
    @post = Post.new
  end

  def create
    @user = current_user
    @post = @user.posts.new(Title: post_params[:Title], Text: post_params[:Text])
    if @post.save
      @post.update_posts_counter
      redirect_to current_user
      flash[:notice] = 'You have successfully created a post'
    else
      render :new, alert: 'Error'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:Title, :Text)
  end
end

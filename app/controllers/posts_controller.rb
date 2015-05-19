class PostsController < ApplicationController
  before_action :get_post, only: [:show, :destroy]
  before_action :get_comments, only: [:show]
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def show
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = 'Post succesfully saved'
      redirect_to post_path(@post)
    else
      flash[:warn] = 'Your post sucks. Please try again'
      redirect_to new_post_path
    end
  end

  def destroy
    if @post.destroy!
      redirect_to root_path
    else
      flash[:warn] = 'Post could not be deleted'
      redirect_to post_path
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body).merge(user_id: current_user.id)
  end

  def get_post
    @post = Post.find(params[:id])
  end

  def get_comments
    @comments = @post.comments
  end
end

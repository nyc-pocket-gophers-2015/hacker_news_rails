class CommentsController < ApplicationController
  before_action :get_post, only: [:new, :create, :destroy]
  before_action :get_comment, only: [:destroy]
  def show
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save!
      redirect_to post_path(@post)
    else
      flash[:warn] = "Sorry comment wasn't saved"
      redirect_to new_post_comment_path
    end
  end

  def destroy
    if @comment.destroy!
      redirect_to post_path(@post)
    else
      flash[:warn] = 'Comment was not removed'
      redirect_to post_comment_path(@post, @comment)
    end
  end

  private
  def get_post
    @post = Post.find(params[:post_id])
  end

  def get_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body).merge(post_id: params[:post_id], user_id: current_user.id)
  end
end

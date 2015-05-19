class CommentsController < ApplicationController
  before_action :get_post, only: [:new, :create]
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

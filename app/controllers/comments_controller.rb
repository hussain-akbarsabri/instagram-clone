# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_post, only: %i[create ]
  before_action :set_comment, only: %i[show edit update destroy]

  def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = 'Comment successfully added'
      redirect_to post_path(@post)
    else
      flash.now[:danger] = 'error'
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @comment.update(comment_params)
      flash[:success] = 'Post has been successfully updated.'
      redirect_to post_path(@comment.post)
    else
      render 'edit'
    end
  end

  def destroy
    @comment.destroy

    flash[:notice] = 'Comment was deleted!'
    redirect_to post_path(@comment.post)
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :content)
  end
end

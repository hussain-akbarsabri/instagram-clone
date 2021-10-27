# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_post, only: %i[new create]
  before_action :set_comment, only: %i[edit update destroy]
  before_action :authorize_user, only: %i[edit update destroy]

  def new
    @comment = @post.comments.new
    authorize @comment
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    authorize @comment

    if @comment.save
      flash[:notice] = 'Comment created successfully.'
    else
      flash[:alert] = @comment.errors.full_messages
    end

    redirect_to post_path(@post)
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      flash[:notice] = 'Comment updated successfully.'
    else
      flash[:alert] = @comment.errors.full_messages
    end

    redirect_to post_path(@comment.post)
  end

  def destroy
    if @comment.destroy
      flash[:notice] = 'Comment deleted successfully.'
    else
      flash[:alert] = @comment.errors.full_messages
    end

    redirect_to post_path(@comment.post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def authorize_user
    authorize @comment
  end
end

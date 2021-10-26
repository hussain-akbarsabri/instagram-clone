# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :set_post, only: %i[create]
  before_action :set_post_like, only: %i[destroy]

  def create
    if liked.present?
      flash[:notice] = "You can't like more than once."
    else
      @like = @post.likes.new(user_id: current_user.id)
      authorize @like
      flash[:alert] = @like.errors.full_messages unless @like.save
    end

    redirect_to post_path(@post)
  end

  def destroy
    if liked.blank?
      flash[:notice] = "You can't unlike more than once."
    else
      @like = Like.find_by!(post_id: @post.id, user_id: current_user.id)
      authorize @like
      flash[:alert] = @like.errors.full_messages unless @like.destroy
    end

    redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_post_like
    @post = Post.find(params[:id])
  end

  def liked
    Like.liked(@post.id, current_user.id)
  end
end

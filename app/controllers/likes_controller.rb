# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :set_post, only: %i[create]

  def create
    if already_liked?
      flash[:notice] = "You can't like more than once."
    else
      @post.likes.create(user_id: current_user.id)
    end
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    @like = Like.find_by(post_id: @post.id, user_id: current_user.id)
    if !already_liked?
      flash[:notice] = 'You cannot unlike'
    else
      @like.destroy
    end

    redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
  # move already like to scope

  def already_liked?
    Like.where(post_id: @post.id, user_id: current_user.id).exists?
  end
end

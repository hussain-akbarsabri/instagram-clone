# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @followed_users = current_user.followings
    @followed_users.each do |user|
      @user_now = User.find(user.following_id)
      @posts = @user_now.posts.order('created_at DESC')
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      flash[:notice] = 'Post created successfully.'
      redirect_to user_path(params[:user_id])
    else
      flash[:alert] = 'Post didnt created'
      redirect_to new_user_post_path
    end
  end

  def show; end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Post updated successfully.'
      redirect_to @post
    else
      flash[:alert] = 'you cant update'
      render 'edit'
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = 'Post deleted successfully.'
      redirect_to user_path(params[:format])
    else
      flash[:error] = @post.errors
    end
  end

  private

  def post_params
    params.require(:post).permit(:caption, images: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end

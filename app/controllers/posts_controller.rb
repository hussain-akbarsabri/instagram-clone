# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_user, only: %i[new create]
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authorize_user, only: %i[show edit update destroy]

  def feed
    @followings = current_user.followings
  end

  def new
    @post = @user.posts.new
    authorize @post
  end

  def create
    @post = @user.posts.new(post_params)
    authorize @post

    if @post.save
      flash[:notice] = 'Post created successfully.'
    else
      flash[:alert] = @post.errors.full_messages
    end
    redirect_to user_path(current_user)
  end

  def show
    @images = @post.images.page(params[:page]).per(1)
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Post updated successfully.'
      redirect_to @post
    else
      flash[:alert] = @post.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = 'Post deleted successfully.'
    else
      flash[:alert] = @post.errors.full_messages
    end
    redirect_to user_path current_user
  end

  private

  def post_params
    params.require(:post).permit(:caption, images: [])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user
    authorize @post
  end
end

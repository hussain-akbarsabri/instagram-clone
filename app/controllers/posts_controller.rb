# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authorize_post, only: %i[edit destroy]

  def index
    @followings = current_user.followings
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
      flash[:alert] = @post.erros
      redirect_to new_user_post_path
    end
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
      flash[:alert] = 'you cant update'
      render 'edit'
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = 'Post deleted successfully.'
    else
      flash[:error] = @post.errors
    end
    redirect_to user_path current_user
  end

  private

  def post_params
    params.require(:post).permit(:caption, images: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_post
    authorize @post
  end
end

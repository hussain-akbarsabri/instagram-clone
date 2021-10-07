# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.all.includes(:comments)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      flash[:notice] = 'Post has successfully created.'
      redirect_to user_path(params[:user_id])
    else
      flash[:alert] = @post.errors
      redirect_to new_user_post_path
    end
  end

  def show; end

  def edit
    @post.save
  end

  def update
    authorize @post
    if @post.update(post_params)
      flash[:success] = 'Post has been successfully updated.'
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:danger] = 'Post has been successfully deleted.'
    redirect_to user_path(params[:format])
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:caption, :image)
  end
end

# frozen_string_literal: true

class StoriesController < ApplicationController
  before_action :set_story, only: %i[show edit update destroy]

  def new
    @story = Story.new
  end

  def create
    @story = current_user.stories.new(story_params)

    if @story.save
      flash[:notice] = 'Story created successfully.'
      redirect_to user_path(params[:user_id])
    else
      flash[:alert] = @story.errors
      redirect_to back
    end
  end

  def show; end

  def edit; end

  def update
    if @story.update(story_params)
      flash[:notice] = 'Story updated successfully.'
      redirect_to @story
    else
      flash[:alert] = 'you cant update'
      render 'edit'
    end
  end

  def destroy
    if @story.destroy
      flash[:notice] = 'Story deleted successfully.'
      redirect_to user_path current_user
    else
      flash[:error] = @story.errors
    end
  end

  private

  def story_params
    params.require(:story).permit(:image)
  end

  def set_story
    @story = Story.find(params[:id])
  end
end

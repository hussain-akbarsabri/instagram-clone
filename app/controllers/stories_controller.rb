# frozen_string_literal: true

class StoriesController < ApplicationController
  before_action :set_story, only: %i[show edit update destroy]
  before_action :authorize_story, only: %i[edit update destroy]

  def new
    @story = Story.new
  end

  def create
    @story = current_user.stories.new(story_params)
    authorize @story

    if @story.save
      flash[:notice] = 'Story created successfully.'
    else
      flash[:alert] = @story.errors.full_messages
    end

    redirect_to user_path(params[:user_id])
  end

  def show; end

  def edit; end

  def update
    if @story.update(story_params)
      flash[:notice] = 'Story updated successfully.'
    else
      flash[:alert] = @story.errors.full_messages
    end

    redirect_to @story
  end

  def destroy
    if @story.destroy
      flash[:notice] = 'Story deleted successfully.'
    else
      flash[:error] = @story.errors.full_messages
    end

    redirect_to user_path current_user
  end

  private

  def story_params
    params.require(:story).permit(:image)
  end

  def set_story
    @story = Story.find(params[:id])
  end

  def authorize_story
    authorize @story
  end
end

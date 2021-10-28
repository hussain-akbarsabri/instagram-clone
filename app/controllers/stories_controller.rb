# frozen_string_literal: true

class StoriesController < ApplicationController
  before_action :set_user, only: %i[new create]
  before_action :set_story, only: %i[show edit update destroy]
  before_action :authorize_user, only: %i[show edit update destroy]

  def new
    @story = @user.stories.new
    authorize @story
  end

  def create
    @story = @user.stories.new(story_params)
    authorize @story

    if @story.save
      create_job_for_deleting
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
    remove_job_from_queue
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

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_story
    @story = Story.find(params[:id])
  end

  def create_job_for_deleting
    @story.job_id = DeleteStoryJob.set(wait: 24.hours).perform_later(@story).provider_job_id
    @story.save
  end

  def remove_job_from_queue
    queue = Sidekiq::ScheduledSet.new
    queue.each do |job|
      job.delete if job.jid == @story.job_id
    end
  end

  def authorize_user
    authorize @story
  end
end

# frozen_string_literal: true

class DeleteStoryJob < ApplicationJob
  def perform(story)
    Story.find!(story.id).destroy
  end
end

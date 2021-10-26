# frozen_string_literal: true

class Story < ApplicationRecord
  def self.create_job_for_deleting(story)
    story.job_id = DeleteStoryJob.set(wait: 24.hours).perform_later(story).provider_job_id
  end

  def self.remove_job_for_deleting
    queue = Sidekiq::ScheduledSet.new
    queue.each do |job|
      job.delete if job.jid == @story.job_id
    end
  end

  has_one_attached :image
  belongs_to :user

  validates :image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']
end

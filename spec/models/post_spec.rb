# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/allow_content_type'

RSpec.describe Post, type: :model do
  Sidekiq::Testing.inline!
  include ActiveJob::TestHelper

  let(:user) { FactoryBot.create(:user) }
  let(:new_post) { FactoryBot.create(:post, user_id: user.id) }
  let(:post_images) { FactoryBot.create(:post).images }
  let(:post_with_images) { FactoryBot.create(:post) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many_attached(:images) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_length_of(:caption).is_at_most(150) }
    it { is_expected.to allow_content_types('image/png', 'image/jpeg').for(:images) }
    it { expect(post_images).to be_an_instance_of(ActiveStorage::Attached::Many) }

    it 'is expected to validate that :image cannot shold be present' do
      expect(new_post.images).to be_present
    end

    it 'is expected to validate that :image have more than 1 images' do
      expect(new_post.images.count).to be > 0
    end

    it 'is expected to validate that :image have less than or equal to 10 images' do
      post_with_images
      11.times do
        post_with_images.images.attach(Rack::Test::UploadedFile.new(Rails.root.join('spec/photos/image.png'),
                                                                    'image/png'))
      end
      expect do
        post_with_images.save!
      end.to raise_error(ActiveRecord::RecordInvalid,
                         'Validation failed: Images total number is out of range')
      expect(new_post.images.count).to be <= 10
    end
  end
end

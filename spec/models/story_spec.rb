# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/allow_content_type'

RSpec.describe Story, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:story) { FactoryBot.create(:story, user_id: user.id) }

  describe 'associations' do
    it { is_expected.to have_one_attached(:image) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:image) }
    it { is_expected.to allow_content_types('image/png', 'image/jpeg', 'image/jpg').for(:image) }

    it 'is expected to validate that :image cannot be empty/falsy' do
      expect(story.image).to be_present
    end
  end
end

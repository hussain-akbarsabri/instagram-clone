# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Follow, type: :model do
  # let(:user1) { create(:user) }
  # let(:user2) { create(:user) }
  # let!(:new_follow1) { create(:follow, following_id: user1.id, follower_id: user2.id) }
  # let!(:new_follow2) { create(:follow, following_id: user1.id, follower_id: user2.id) }

  describe 'associations' do
    it { is_expected.to belong_to(:follower) }
    it { is_expected.to belong_to(:following) }
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:follower_id).scoped_to(:following_id) }
  end
end

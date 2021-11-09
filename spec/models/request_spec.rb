# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Request, type: :model do
  # let(:user1) { create(:user) }
  # let(:user2) { create(:user) }
  # let!(:new_request1) { create(:request, following_id: user1.id, follower_id: user2.id) }
  # let!(:new_request2) { create(:request, following_id: user1.id, follower_id: user2.id) }
  describe 'associations' do
    it { is_expected.to belong_to(:follower) }
    it { is_expected.to belong_to(:following) }
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:follower_id).scoped_to(:following_id) }
  end
end

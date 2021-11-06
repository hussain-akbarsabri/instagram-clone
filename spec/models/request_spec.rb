# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Request, type: :model do
  let(:follow) { create(:follow, following_id: '10', follower_id: '10') }

  describe 'associations' do
    it { is_expected.to belong_to(:follower) }
    it { is_expected.to belong_to(:following) }
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:follower_id).scoped_to(:following_id) }
  end
end

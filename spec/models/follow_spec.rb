# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Follow, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:follower) }
    it { is_expected.to belong_to(:following) }
  end

  describe 'validations' do
    # it { is_expected.to validate_uniqueness_of(:follower_id).case_insensitive.scoped_to(:following_id) }
  end
end

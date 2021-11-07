# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user_id: user.id) }
  # let!(:first_like) { FactoryBot.create(:like, user_id: user.id, post_id: post.id) }
  # let!(:second_like) { FactoryBot.create(:like, user_id: user.id, post_id: post.id) }

  describe 'associations' do
    it { is_expected.to belong_to(:post) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it 'make sure liked or not' do
      expect(described_class.liked(post.id, user.id).count).to be < 2
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FollowsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:user1) { FactoryBot.create(:user) }
  let(:follow) { FactoryBot.create(:follow, following_id: user1.id, follower_id: user.id) }

  before do
    sign_in user
  end

  describe 'POST follows#accept_follow' do
    it 'accepts follow' do
      post :unfollow, params: { id: user.id }
      # response.status.should be(302)
      # expect(response).to redirect_to(user_path(user.id))
    end
  end
end

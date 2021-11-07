# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/devise'

RSpec.describe FollowsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:user1) { FactoryBot.create(:user, status: true) }
  let(:user2) { FactoryBot.create(:user, status: false) }
  let(:follow) { FactoryBot.create(:follow, following_id: user2.id, follower_id: user.id) }

  before do
    sign_in user
  end

  describe 'POST follows#follow' do
    context 'with correct params' do
      it 'will not make a follow if user follow himself' do
        expect do
          post :follow, params: { id: user.id }
        end.to change(Follow, :count).by(+0)
        expect(flash[:alert]).to eq('You are not authorized.')
        expect(response).to redirect_to root_path
      end

      it 'makes a follow if user is public' do
        expect do
          post :follow, params: { id: user2.id }
        end.to change(Follow, :count).by(+1)
        expect(response).to redirect_to user_path(user2)
      end

      it 'makes a request if user is private' do
        expect do
          post :follow, params: { id: user1.id }
        end.to change(Request, :count).by(+1)
        expect(response).to redirect_to user_path(user1)
      end
    end

    context 'with wrong params' do
      it 'wrong user id will not make a follow or request' do
        expect do
          post :follow, params: { id: 0 }
        end.to change(Follow, :count).by(0)
        expect do
          post :follow, params: { id: 0 }
        end.to change(Request, :count).by(0)
        expect(flash[:alert]).to eq('Record Not Found')
        expect(response).to redirect_to root_path
      end
    end

    context 'when user is not authenticate' do
      it 'will make user to sign in' do
        sign_out user
        expect do
          post :unfollow, params: { id: user2.id }
        end.to change(Follow, :count).by(0)
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST follows#unfollow' do
    context 'with correct params' do
      it 'will unfollow a user' do
        follow
        expect do
          post :unfollow, params: { id: user2.id }
        end.to change(Follow, :count).by(-1)
        expect(response).to redirect_to user_path(user2)
      end
    end

    context 'with wrong params' do
      it 'will not unfollow if not followed' do
        expect do
          post :unfollow, params: { id: user1.id }
        end.to change(Follow, :count).by(0)
        expect(flash[:alert]).to eq('Record Not Found')
        expect(response).to redirect_to root_path
      end

      it 'will not unfollow if wrong user given' do
        expect do
          post :unfollow, params: { id: 0 }
        end.to change(Follow, :count).by(0)
        expect(flash[:alert]).to eq('Record Not Found')
        expect(response).to redirect_to root_path
      end
    end

    context 'when user is not authenticate' do
      it 'will make user to sign in' do
        sign_out user
        expect do
          post :unfollow, params: { id: user2.id }
        end.to change(Follow, :count).by(0)
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST follows#accept_follow' do
    let(:follow_request) { FactoryBot.create(:request, following_id: user.id, follower_id: user1.id) }

    context 'with correct params' do
      it 'will make a follow and delete a request' do
        expect do
          post :accept_follow, params: { id: follow_request.id }
        end.to change(Follow, :count).by(+1)
        expect(response).to redirect_to user_path user
      end
    end

    context 'with wrong params' do
      it 'will not make a follow if request is not made' do
        expect do
          post :accept_follow, params: { id: 0 }
        end.to change(Follow, :count).by(0)
        expect(flash[:alert]).to include('Record Not Found')
        expect(response).to redirect_to root_path
      end
    end

    context 'when user is not authenticate' do
      it 'will make user to sign in' do
        sign_out user
        expect do
          post :unfollow, params: { id: user2.id }
        end.to change(Follow, :count).by(0)
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end

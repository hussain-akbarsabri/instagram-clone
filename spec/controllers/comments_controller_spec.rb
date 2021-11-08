# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/devise'

RSpec.describe CommentsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:comment_post) { FactoryBot.create(:post, user_id: user.id) }

  before do
    sign_in user
  end

  describe 'POST comments#create' do
    context 'with correct params' do
      it 'creates a new comment' do
        expect do
          post :create, params: { post_id: comment_post.id, content: 'This is a dummy content' }, xhr: true
        end.to change(Comment, :count).by(+1)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with wrong params' do
      it 'empty content will not create a new comment' do
        expect do
          post :create, params: { post_id: comment_post.id, content: nil }, xhr: true
        end.to change(Comment, :count).by(0)
        expect(flash[:alert]).to include("Content can't be blank")
        expect(response).to have_http_status(:ok)
      end

      it 'wrong post id will not create a new comment' do
        expect do
          post :create, params: { post_id: 0, content: 'This is a dummy content' }, xhr: true
        end.to change(Comment, :count).by(0)
        expect(flash[:alert]).to eq('Record Not Found')
        expect(response).to redirect_to root_path
      end
    end

    context 'when user is not authenticate' do
      it 'will make user to sign in' do
        sign_out user
        expect do
          post :create, params: { post_id: comment_post.id, content: 'This is a dummy content' }, xhr: true
        end.to change(Comment, :count).by(0)
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to eq('You need to sign in or sign up before continuing.')
      end
    end
  end

  describe 'GET comments#edit' do
    context 'with correct params' do
      let(:my_new_comment) { FactoryBot.create(:comment, user_id: user.id) }

      it 'renders edit template' do
        get :edit, params: { id: my_new_comment.id }
        expect(response).to render_template(:edit)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with wrong params' do
      it 'will not renders edit template' do
        get :edit, params: { id: 0 }
        expect(flash[:alert]).to eq('Record Not Found')
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to root_path
      end
    end

    context 'when user is not authenticate' do
      it 'will make user to sign in' do
        sign_out user
        expect do
          post :create, params: { post_id: comment_post.id, content: 'This is a dummy content' }, xhr: true
        end.to change(Comment, :count).by(0)
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to eq('You need to sign in or sign up before continuing.')
      end
    end
  end

  describe 'PUT comments#update' do
    context 'with correct params' do
      let(:my_new_comment) { FactoryBot.create(:comment, user_id: user.id) }

      it 'updates the comment with content' do
        put :update, params: { id: my_new_comment.id, comment: { content: 'This is a dummy content' } }
        expect(flash[:notice]).to include('Comment updated successfully.')
        expect(response).to redirect_to post_path(my_new_comment.post)
      end

      it 'not updates the comment without content' do
        put :update, params: { id: my_new_comment.id, comment: { content: nil } }
        expect(flash[:alert]).to include("Content can't be blank")
        expect(response).to redirect_to post_path(my_new_comment.post)
      end
    end

    context 'with wrong params' do
      it 'will not update comment' do
        put :update, params: { id: 0 }
        expect(flash[:alert]).to include('Record Not Found')
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to root_path
      end
    end

    context 'when user is not authenticate' do
      it 'will make user to sign in' do
        sign_out user
        expect do
          post :create, params: { post_id: comment_post.id, content: 'This is a dummy content' }, xhr: true
        end.to change(Comment, :count).by(0)
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to eq('You need to sign in or sign up before continuing.')
      end
    end
  end

  describe 'DELETE comments#destroy' do
    context 'with correct params' do
      let(:my_new_comment) { FactoryBot.create(:comment, user_id: user.id) }

      it 'delete a comment' do
        delete :destroy, params: { id: my_new_comment.id }, xhr: true
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with wrong params' do
      it 'will not delete comment' do
        delete :destroy, params: { id: 0 }, xhr: true
        expect(flash[:alert]).to include('Record Not Found')
        expect(response).to have_http_status(:ok)
        expect(response).to redirect_to root_path
      end
    end

    context 'when user is not authenticate' do
      it 'will make user to sign in' do
        sign_out user
        expect do
          post :create, params: { post_id: comment_post.id, content: 'This is a dummy content' }, xhr: true
        end.to change(Comment, :count).by(0)
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to eq('You need to sign in or sign up before continuing.')
      end
    end
  end
end

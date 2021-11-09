# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/devise'

RSpec.describe CommentsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:comment_post) { FactoryBot.create(:post, user_id: user.id) }

  before do
    sign_in user
  end

  describe 'Comments controller create action' do
    context 'with correct params' do
      it 'creates a new comment' do
        expect do
          post :create, params: { post_id: comment_post.id, content: 'This is a dummy content' }, xhr: true
        end.to change(Comment, :count).by(1)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with wrong params' do
      it 'will not create a new comment without content' do
        expect do
          post :create, params: { post_id: comment_post.id, content: nil }, xhr: true
        end.to change(Comment, :count).by(0)
        expect(flash[:alert]).to include("Content can't be blank")
      end

      it 'will not create a new comment without post id' do
        expect do
          post :create, params: { post_id: 0, content: 'This is a dummy content' }, xhr: true
        end.to change(Comment, :count).by(0)
        expect(flash[:alert]).to eq('Record Not Found')
        expect(response).to redirect_to root_path
      end
    end

    context 'when user is not signed in' do
      it 'will not create comment and redirect user to sign in page' do
        sign_out user
        expect do
          post :create, params: { post_id: comment_post.id, content: 'This is a dummy content' }, xhr: true
        end.to change(Comment, :count).by(0)
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to eq('You need to sign in or sign up before continuing.')
      end
    end

    context 'when user is not authorize' do
      let(:pvt_user) { FactoryBot.create(:user, status: true) }
      let(:new_post) { FactoryBot.create(:post, user_id: pvt_user.id) }

      it 'will not allow user to create a comment' do
        post :create, params: { post_id: new_post.id, content: 'This is a dummy content' }
        expect(flash[:alert]).to eq('You are not authorized.')
        expect(response).to redirect_to root_path
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe 'Comments controller edit action' do
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

    context 'when user is not signed in' do
      it 'will not show edit page and redirect user to sign in page' do
        sign_out user
        expect do
          get :edit, params: { id: 0 }
        end.to change(Comment, :count).by(0)
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when user is not authorize' do
      let(:pvt_user) { FactoryBot.create(:user, status: true) }
      let(:my_new_comment) { FactoryBot.create(:comment, user_id: pvt_user.id) }

      it 'will not allow user to render edit page' do
        get :edit, params: { id: my_new_comment.id }
        expect(flash[:alert]).to eq('You are not authorized.')
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'Comments controller update action ' do
    context 'with correct params' do
      let(:my_new_comment) { FactoryBot.create(:comment, user_id: user.id) }

      it 'updates the comment with content' do
        put :update, params: { id: my_new_comment.id, comment: { content: 'This is a dummy content' } }
        expect(flash[:notice]).to eq('Comment updated successfully.')
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
        expect(flash[:alert]).to eq('Record Not Found')
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to root_path
      end
    end

    context 'when user is not signed in' do
      it 'will not update comment and redirect user to sign in page' do
        sign_out user
        expect do
          put :update, params: { id: 0 }
        end.to change(Comment, :count).by(0)
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when user is not authorize' do
      let(:pvt_user) { FactoryBot.create(:user, status: true) }
      let(:my_new_comment) { FactoryBot.create(:comment, user_id: pvt_user.id) }

      it 'will not allow user to update' do
        put :update, params: { id: my_new_comment.id }
        expect(flash[:alert]).to eq('You are not authorized.')
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'Comments controller destroy action' do
    context 'with correct params' do
      let(:my_new_comment) { FactoryBot.create(:comment, user_id: user.id) }

      it 'deletes a comment' do
        delete :destroy, params: { id: my_new_comment.id }, xhr: true
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with wrong params' do
      it 'will not delete comment' do
        delete :destroy, params: { id: 0 }, xhr: true
        expect(flash[:alert]).to eq('Record Not Found')
        expect(response).to have_http_status(:ok)
        expect(response).to redirect_to root_path
      end
    end

    context 'when user is not signed in' do
      it 'will not delete a comment and redirect user to sign in page' do
        sign_out user
        expect do
          delete :destroy, params: { id: 0 }, xhr: true
        end.to change(Comment, :count).by(0)
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to eq('You need to sign in or sign up before continuing.')
      end
    end

    context 'when user is not authorize' do
      let(:pvt_user) { FactoryBot.create(:user, status: true) }
      let(:my_new_comment) { FactoryBot.create(:comment, user_id: pvt_user.id) }

      it 'will not allow user to destroy' do
        delete :destroy, params: { id: my_new_comment.id }
        expect(flash[:alert]).to eq('You are not authorized.')
        expect(response).to redirect_to root_path
      end
    end
  end
end

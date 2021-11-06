# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/devise'

RSpec.describe CommentsController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:comment_post) { FactoryBot.create(:post, user_id: user.id) }

  before do
    sign_in user
  end

  describe 'POST comments#create' do
    context 'with content' do
      let(:params) do
        { post_id: comment_post.id, content: 'akhsdgjhsd' }
      end

      it 'creates a new comment' do
        expect do
          post :create, params: params, xhr: true
        end.to change(Comment, :count).by(+1)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'without content' do
      let(:params) do
        { post_id: comment_post.id, content: nil }
      end

      it 'will not creates a new comment' do
        expect do
          post :create, params: params, xhr: true
        end.to change(Comment, :count).by(0)
        expect(flash[:alert]).to include("Content can't be blank")
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET comments#edit' do
    context 'with created comment' do
      let(:my_new_comment) { FactoryBot.create(:comment, user_id: user.id) }

      it 'renders edit template' do
        get :edit, params: { id: my_new_comment.id }
        expect(response).to render_template(:edit)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'without created comment' do
      it 'will not renders edit template' do
        get :edit, params: { id: 339_816 }
        expect(flash[:alert]).to include('Record Not Found')
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe 'PUT comments#update' do
    context 'with created comment' do
      let(:my_new_comment) { FactoryBot.create(:comment, user_id: user.id) }

      it 'updates the comment with content' do
        put :update, params: { id: my_new_comment.id, comment: { content: 'kskajbs' } }
        expect(flash[:notice]).to include('Comment updated successfully.')
        expect(response).to redirect_to post_path(my_new_comment.post)
      end

      it 'not updates the comment without content' do
        put :update, params: { id: my_new_comment.id, comment: { content: '' } }
        expect(flash[:alert]).to include("Content can't be blank")
        expect(response).to redirect_to post_path(my_new_comment.post)
      end
    end

    context 'without created comment' do
      it 'will not update comment' do
        put :update, params: { id: 339_816, comment: { content: '' } }
        expect(flash[:alert]).to include('Record Not Found')
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe 'DELETE comments#destroy' do
    context 'with created comment' do
      let(:my_new_comment) { FactoryBot.create(:comment, user_id: user.id) }

      it 'delete a comment' do
        delete :destroy, params: { id: my_new_comment.id }, xhr: true
        expect(response).to have_http_status(:ok)
      end
    end

    context 'without created comment' do
      it 'will not delete comment' do
        delete :destroy, params: { id: 339_816 }, xhr: true
        expect(flash[:alert]).to include('Record Not Found')
        expect(response).to have_http_status(:ok)
      end
    end
  end
end

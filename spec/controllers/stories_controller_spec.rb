# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/devise'

RSpec.describe StoriesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  describe 'POST stories#new' do
    context 'with correct params' do
      it 'render new template' do
        get :new, params: { user_id: user.id }
        expect(response).to render_template(:new)
      end
    end

    context 'with wrong params' do
      it 'will not render new template' do
        get :new, params: { user_id: 0 }
        expect(flash[:alert]).to eq('Record Not Found')
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST stories#create' do
    context 'with correct params' do
      let(:params) do
        { story: { image: Rack::Test::UploadedFile.new(Rails.root.join('spec/photos/image.png'), 'image/png') },
          user_id: user.id }
      end

      it 'creates a new story' do
        expect do
          post :create, params: params
        end.to change(Story, :count).by(+1)
        expect(flash[:notice]).to eq('Story created successfully.')
        expect(response).to redirect_to user_path(user)
      end
    end

    context 'with wrong params' do
      let(:wrong_format_params) do
        { story: { image: Rack::Test::UploadedFile.new(Rails.root.join('spec/photos/temp.txt'), 'file/txt') },
          user_id: user.id }
      end

      let(:without_user_params) do
        { story: { image: Rack::Test::UploadedFile.new(Rails.root.join('spec/photos/temp.txt'), 'file/txt') },
          user_id: 0 }
      end

      let(:without_image_params) do
        { story: {},
          user_id: 0 }
      end

      # it 'without image will not create a new story' do
      #   expect do
      #     post :create, params: without_image_params
      #   end.to change(Story, :count).by(0)
      #   expect(flash[:alert]).to include('Image has an invalid content type')
      #   expect(response).to redirect_to user_path(user)
      #   expect(response).to have_http_status(:ok)
      # end

      # it 'wrong image type will not create a new story' do
      #   expect do
      #     post :create, params: wrong_format_params
      #   end.to change(Story, :count).by(0)
      #   expect(flash[:alert]).to include('Image has an invalid content type')
      #   expect(response).to redirect_to user_path(user)
      #   expect(response).to have_http_status(:ok)
      # end

      it 'wrong user id will not create a new story' do
        expect do
          post :create, params: without_user_params
        end.to change(Story, :count).by(0)
        expect(flash[:alert]).to eq('Record Not Found')
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET stories#edit' do
    it 'render stories#new template' do
      story = create(:story, user_id: user.id)
      get :edit, params: { id: story.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'GET stories#show' do
    it 'shows a story' do
      story = create(:story, user: user)
      get :show, params: { id: story.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'PUT stories#update' do
    context 'with correct params' do
      let(:story) { create(:story, user_id: user.id) }
      let(:param) do
        { story: { image: Rack::Test::UploadedFile.new(Rails.root.join('spec/photos/image.png'), 'image/png') },
          id: story.id }
      end

      it 'updates an exsisting story' do
        put :update, params: param
        expect(response).to redirect_to story_path(story)
      end
    end
  end

  describe 'DELETE stories#destroy' do
    context 'with created story' do
      let(:my_new_story) { FactoryBot.create(:story, user_id: user.id) }

      it 'delete a story' do
        expect do
          delete :destroy, params: { id: my_new_story.id }
        end.to change(Story, :count).by(0)
      end
    end

    context 'without created story' do
      it 'will not delete story' do
        delete :destroy, params: { id: 339_816 }
        expect(flash[:alert]).to include('Record Not Found')
      end
    end
  end
end

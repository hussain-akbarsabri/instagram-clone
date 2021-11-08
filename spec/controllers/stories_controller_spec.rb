# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/devise'

RSpec.describe StoriesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:new_story) { FactoryBot.create(:story, user_id: user.id) }

  before do
    sign_in user
  end

  describe 'Stories controller new action' do
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

    context 'when user is not authenticate' do
      it 'will make user to sign in' do
        sign_out user
        get :new, params: { user_id: user.id }
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/users/sign_in">redirected</a>.</body></html>')
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when user is not authorize' do
      let(:user2) { FactoryBot.create(:user) }

      it 'will not allow user to perform action' do
        get :new, params: { user_id: user2.id }
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/">redirected</a>.</body></html>')
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'Stories controller create action' do
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
      let(:wrong_param) do
        { story: { image: Rack::Test::UploadedFile.new(Rails.root.join('.rubocop.yml'), 'file/yml') },
          user_id: user.id }
      end

      it 'will not create a new story' do
        expect do
          post :create, params: wrong_param
        end.to change(Story, :count).by(0)
        expect(response).to redirect_to user
      end

      it 'wrong user id will throw exception' do
        expect do
          post :create, params: { user_id: 0 }
        end.to change(Story, :count).by(0)
        expect(flash[:alert]).to eq('Record Not Found')
        expect(response).to redirect_to root_path
      end
    end

    context 'when user is not authenticate' do
      it 'will make user to sign in' do
        sign_out user
        post :create, params: { user_id: 0 }
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/users/sign_in">redirected</a>.</body></html>')
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when user is not authorize' do
      let(:user2) { FactoryBot.create(:user) }
      let(:params) do
        { story: { image: Rack::Test::UploadedFile.new(Rails.root.join('spec/photos/image.png'), 'image/png') },
          user_id: user2.id }
      end

      it 'will not allow user to create story' do
        post :create, params: params
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/">redirected</a>.</body></html>')
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'Stories controller edit action' do
    context 'with correct params' do
      it 'render edit template' do
        get :edit, params: { id: new_story.id }
        expect(response).to render_template(:edit)
      end
    end

    context 'with wrong params' do
      it 'will not render edit template' do
        get :edit, params: { id: 0 }
        expect(flash[:alert]).to eq('Record Not Found')
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to root_path
      end
    end

    context 'when user is not authenticate' do
      it 'will make user to sign in' do
        sign_out user
        post :edit, params: { id: 0 }
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/users/sign_in">redirected</a>.</body></html>')
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when user is not authorize' do
      let(:story) { FactoryBot.create(:story) }

      it 'will not allow user to edit story' do
        get :edit, params: { id: story.id }
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/">redirected</a>.</body></html>')
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'Stories controller show action' do
    context 'with correct params' do
      it 'shows a story' do
        get :show, params: { id: new_story.id }
        expect(response).to render_template(:show)
      end
    end

    context 'with wrong params' do
      it 'will not show a story' do
        get :show, params: { id: 0 }
        expect(flash[:alert]).to eq('Record Not Found')
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to root_path
      end
    end

    context 'when user is not authenticate' do
      it 'will make user to sign in' do
        sign_out user
        get :show, params: { id: 0 }
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/users/sign_in">redirected</a>.</body></html>')
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when user is not authorize' do
      let(:user2) { FactoryBot.create(:user, status: true) }
      let(:story) { FactoryBot.create(:story, user_id: user2.id) }

      it 'will not allow user to show story' do
        get :show, params: { id: story.id }
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/">redirected</a>.</body></html>')
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'Stories controller update action' do
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

    context 'with wrong params' do
      let(:story) { FactoryBot.create(:story, user_id: user.id) }
      let(:param) do
        { story: { image: Rack::Test::UploadedFile.new(Rails.root.join('spec/photos/image.png'), 'image/png') },
          id: story.id }
      end

      it 'will not delete story ' do
        allow_any_instance_of(Story).to receive(:update).and_return(false)
        put :update, params: param
        expect(response).to redirect_to story_path(story)
      end

      it 'will throw record_not_found exception' do
        put :update, params: { id: 0 }
        expect(flash[:alert]).to include('Record Not Found')
        expect(response).to redirect_to root_path
      end
    end

    context 'when user is not authenticate' do
      it 'will make user to sign in' do
        sign_out user
        post :update, params: { id: 0 }
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/users/sign_in">redirected</a>.</body></html>')
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when user is not authorize' do
      let(:user2) { FactoryBot.create(:user, status: true) }
      let(:story) { FactoryBot.create(:story, user_id: user2.id) }

      it 'will not allow user to update story' do
        post :update, params: { id: story.id }
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/">redirected</a>.</body></html>')
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'Stories controller destroy action' do
    context 'with correct params' do
      let(:story) { FactoryBot.create(:story, user_id: user.id) }

      it 'will delete story' do
        story
        expect do
          delete :destroy, params: { id: story.id }
        end.to change(Story, :count).by(-1)
        expect(flash[:notice]).to eq('Story deleted successfully.')
        expect(response).to redirect_to user
      end
    end

    context 'with wrong params' do
      let(:story) { FactoryBot.create(:story, user_id: user.id) }

      it 'will not delete story ' do
        allow_any_instance_of(Story).to receive(:destroy).and_return(false)
        delete :destroy, params: { id: story.id }
        expect(response).to redirect_to user
      end

      it 'will throw record_not_found exception' do
        delete :destroy, params: { id: 0 }
        expect(flash[:alert]).to include('Record Not Found')
        expect(response).to redirect_to root_path
      end
    end

    context 'when user is not authenticate' do
      it 'will make user to sign in' do
        sign_out user
        delete :destroy, params: { id: 0 }
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/users/sign_in">redirected</a>.</body></html>')
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when user is not authorize' do
      let(:user2) { FactoryBot.create(:user, status: true) }
      let(:story) { FactoryBot.create(:story, user_id: user2.id) }

      it 'will not allow user to delete story' do
        delete :destroy, params: { id: story.id }
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/">redirected</a>.</body></html>')
        expect(response).to redirect_to root_path
      end
    end
  end
end

# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root 'posts#index'
  get :search, controller: :users

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :users, only: %i[show], shallow: true do
    resources :posts, shallow: true do
      resources :likes, only: %i[create destroy]
      resources :comments, except: %i[index show]
    end
    resources :stories, only: %i[new create show]
  end

  resources :follows do
    member do
      post :follow_user
      post :unfollow_user
    end
  end

  resources :requests, only: %i[show destroy] do
    member do
      post :accept_follow
    end
  end
  post 'follow_user/:id', to: 'relationships#follow_user', as: :follow_user
  post 'unfollow_user/:id', to: 'relationships#unfollow_user', as: :unfollow_user
end

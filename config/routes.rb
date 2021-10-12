# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root 'posts#index'

  get :search, controller: :users

  devise_for :users, controllers: { registrations: 'registrations' }
  devise_for :users

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
  post 'follow_user/:id', to: 'follows#follow_user', as: :follow_user
  post 'unfollow_user/:id', to: 'follows#unfollow_user', as: :unfollow_user

  resources :requests, only: [:show]
  get 'send_follow_request/:id', to: 'requests#send_follow_request', as: :send_follow_request
  get 'accept_follow_request/:id', to: 'requests#accept_follow_request', as: :accept_follow_request
end

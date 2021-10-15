# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'
  get :search, controller: :users
  devise_for :users

  resources :users, only: %i[index show edit update], shallow: true do
    resources :posts, shallow: true do
      resources :likes, only: %i[create destroy]
      resources :comments, except: %i[index show]
    end
    resources :stories
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
end

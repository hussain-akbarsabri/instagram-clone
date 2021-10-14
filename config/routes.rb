# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users

  resources :users, only: %i[show edit update], shallow: true do
    resources :posts, shallow: true do
      resources :likes, only: %i[create destroy]
      resources :comments, except: %i[index show]
    end
  end

  resources :follows, only: %i[] do
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

# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users
<<<<<<< HEAD

  resources :users, only: %i[show edit update], shallow: true do
    resources :posts, shallow: true do
      resources :likes, only: %i[create destroy]
      resources :comments, except: %i[index show]
    end
=======
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'
  resources :users, shallow: true do
    resources :posts
>>>>>>> created feed page of instagram
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
end

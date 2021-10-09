# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'
  resources :users, shallow: true do
    resources :posts
  end
  resources :posts do
    resources :likes
  end
  resources :posts, shallow: true do
    resources :comments
  end
  post 'follow_user/:id', to: 'follows#follow_user', as: :follow_user
  post 'unfollow_user/:id', to: 'follows#unfollow_user', as: :unfollow_user
end

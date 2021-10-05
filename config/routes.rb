# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#index'
  resources :users, shallow: true do
    resources :posts
  end
  resources :posts do
    resources :likes
  end
  resources :posts do
    resources :comments
  end
end

# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root 'posts#index'

  get :search, controller: :users

  devise_for :users, controllers: { registrations: 'registrations' }
  devise_for :users

  resources :users, only: %i[show], shallow: true do
    resources :posts, except: %i[index], shallow: true do
      resources :likes, only: %i[create destroy]
      resources :comments, except: %i[index show]
    end
    resources :stories, except: %i[index]
    member do
      post :follow, controller: :follows
      post :unfollow, controller: :follows
      post :accept_follow, controller: :follows
    end
    collection do
      get :search
    end
  end
  resources :requests, only: %i[show destroy]
end

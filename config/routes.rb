Rails.application.routes.draw do
  get 'reviews/index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :reviews do
    resources :comments
  end

  resources :favorites, only: [:create, :destroy]

  namespace :api do
    namespace :v1 do
      resources :reviews, only: [:new, :create]
    end
  end
=begin
  namespace :api do
    namespace :v1 do
      resources :comments, only: [:index, :create]
    end
  end
=end
  resources :comments do
    member do
      patch 'upvote'
      patch 'downvote'
    end
  end


  root 'reviews#index'
end

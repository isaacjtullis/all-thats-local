Rails.application.routes.draw do
  get 'reviews/index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :reviews do
    resources :comments
  end

  root 'reviews#index'
end

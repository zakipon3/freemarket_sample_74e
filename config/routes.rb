Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  root to: 'users#index'

  resources :items, only: [:new, :create]

  resources :users, only: [:new, :edit, :show] do
    collection do
      get "touroku"
    end
  end
end

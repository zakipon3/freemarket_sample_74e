Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  root to: 'users#index'

  resources :items do
    collection do
      get "set_parents"
      get "set_children"
      get "set_grandchildren"
    end
  end

  resources :users, only: [:new, :edit, :show] do
    collection do
      get "touroku"
    end
  end
end

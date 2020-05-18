Rails.application.routes.draw do
  
  devise_for :users
  root to: 'items#index'
  
  resources :items, only: [:new, :create, :destroy] do
    collection do
      get "detail"
    end
  end

  resources :users, only: [:new, :edit, :show] do
    collection do
      get "touroku"
    end
  end
end

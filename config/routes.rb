Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  root to: 'users#index'
  resources :users, only: [:new, :edit, :show] do
    #仮のルーティングです
    collection do
      get "touroku"
    end
  end
end

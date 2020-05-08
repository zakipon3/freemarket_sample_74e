Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :users, only: [:new, :edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#index'
  resources :users, only: [:new, :edit, :show] do
    #仮のルーティングです
    collection do
      get "touroku"
    end
  end

end

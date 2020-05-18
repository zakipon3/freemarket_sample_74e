Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  
  root to: 'items#index'
  resources :users, only: [:edit, :update]
  resources :items, only: [:new, :create] do
    collection do
      get "detail"
    end

    collection do
      get "purchase"
    end
  end
end

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  root to: 'items#index'

  resources :items do
    collection do
      get "set_parents"
      get "set_children"
      get "set_grandchildren"
      get "detail"
    end
  end

  resources :users, only: [:edit, :update]

    collection do
      get "purchase"
    end
  end
end

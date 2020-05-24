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
      get "set_images"
      get "detail"
      get "list"
      get "purchase"
    end
  end
  
  
  resources :users, only: [:new, :edit, :show] do
    collection do
      get "touroku"
    end
  end

  resources :mypage, only: [:index, :show, :new, :edit, :create] do

    collection do
      get "logout"
    end
    
    collection do
      get "card"
    end
  end


  resources :users, only: [:edit, :update]

end

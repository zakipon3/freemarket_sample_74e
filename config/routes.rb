Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  
  root to: 'items#index'
  # root to: 'users#index'

  resources :items, only: [:new, :create]

  # resources :users, only: [:new, :edit, :show] do
  #   collection do
  #     get "touroku"
  #   end
  # end
end

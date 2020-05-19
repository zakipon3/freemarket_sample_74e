Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  
  resources :items, only: [:new, :create] do
    collection do
      get "detail"
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

end

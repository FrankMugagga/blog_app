Rails.application.routes.draw do
  devise_for :users

  root 'users#index'
  
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :new, :create, :show, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create, :destroy]
    end
  end
  
end

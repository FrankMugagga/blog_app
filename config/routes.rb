Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    root to: 'devise/sessions#new'
  end
  
  get 'post/index'
  get 'post/show'
  get 'user/index'
  get 'user/show'
  get 'pages/hello'

  get 'users/new_form', to: 'users#new_form', as: 'new_user_form'
  post 'users/create_form', to: 'users#create_form', as: 'create_user_form'

  get 'posts/new', to: 'posts#new', as: 'new_post'
  post 'posts/create', to: 'posts#create'

  
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :new, :create, :show] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create, :destroy]
    end
  end
  
end

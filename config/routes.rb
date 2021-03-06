Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'static_pages#index'

  get 'admin_login', to: 'admin#new'
  post 'admin_login' => 'admin#create'
  post 'admin_logout' => 'admin#destroy'

  namespace :api do
    resources :hotsprings, only: %w[index create update destroy]
    resources :articles, only: %w[create destroy]
    resource :sessions, only: %w[create]
    resource :registers, only: %w[create]
    resources :users, only: %w[show update destroy]
    resources :mountains, only: %w[index show]

    resources :favorites, only: %w[create destroy]
    resources :comments, only: %w[create destroy]
    resources :posts, only: %w[create update]

    get 'me', to: 'sessions#me'
    get 'hotspring', to: 'hotsprings#show'
    get 'article', to: 'articles#show'
    post 'image', to: 'hotsprings#image'
    get 'csrf', to: 'sessions#csrf'
    get 'nearby', to: 'google_map#show'
    get 'find', to: 'hotsprings#find'
  end

  get '*path', to: 'static_pages#index', constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }
end

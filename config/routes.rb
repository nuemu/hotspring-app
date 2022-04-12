Rails.application.routes.draw do
  root to: 'static_pages#index'

  namespace :api do
    resources :hotsprings, only: %w[index create update]
    resources :articles, only: %w[create destroy]
    resource :sessions, only: %w[create]
    resource :registers, only: %w[create]
    resources :users, only: %w[index]

    resources :favorites, only: %w[create destroy]
    resources :comments, only: %w[create destroy]
    resources :posts, only: %w[create update]

    get 'me', to: 'sessions#me'
    get 'admin', to: 'sessions#admin'
    get 'hotspring', to: 'hotsprings#show'
    get 'article', to: 'articles#show'
    post 'image', to: 'hotsprings#image'
  end

  get '*path', to: 'static_pages#index', constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }
end

Rails.application.routes.draw do
  root to: 'static_pages#index'

  namespace :api do
    resources :hotsprings, only: %w[index create update]
    resource :articles, only: %w[create]
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
  end

  get '*path', to: 'static_pages#index'
end

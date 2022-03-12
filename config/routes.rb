Rails.application.routes.draw do
  root to: 'static_pages#index'

  namespace :api do
    resources :hotsprings, only: %w[index]
    resource :sessions, only: %w[create]
    resource :registers, only: %w[create]

    resources :comments, only: %w[create]

    get 'me', to: 'sessions#me'
    get 'hotspring', to: 'hotsprings#show'
  end

  get '*path', to: 'static_pages#index'
end

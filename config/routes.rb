Rails.application.routes.draw do
  root to: 'static_pages#index'

  namespace :api do
    resources :hotsprings, only: %w[index show]
    resource :sessions, only: %w[create]
    resource :registers, only: %w[create]

    get 'me', to: 'sessions#me'
  end

  get '*path', to: 'static_pages#index'
end

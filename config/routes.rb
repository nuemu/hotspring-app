Rails.application.routes.draw do
  root to: 'static_pages#index'

  namespace :api do
    resources :hotsprings, only: %w[index show]
    resource :authentication, only: %w[create]
  end

  get '*path', to: 'static_pages#index'
end

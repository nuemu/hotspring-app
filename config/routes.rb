Rails.application.routes.draw do
  root to: 'static_pages#index'

  namespace :api do
    resources :hotsprings
  end

  get '*path', to: 'static_pages#index'
end

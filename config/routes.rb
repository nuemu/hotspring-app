Rails.application.routes.draw do
  root to: 'static_pages#index'
  get '*path', to: 'static_pages#index'
end

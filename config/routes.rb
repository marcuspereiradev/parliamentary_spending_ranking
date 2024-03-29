require 'sidekiq/web'
Rails.application.routes.draw do
  resources :dashboard, only: [:index, :show]

  get 'csv_import/index'
  post 'csv_import', to: 'csv_import#csv_import'

  root to: 'dashboard#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  mount Sidekiq::Web, at: '/sidekiq'
end

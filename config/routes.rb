Rails.application.routes.draw do
  root 'sessions#new'

  get 'login' => 'sessions#new', as: :login
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy', as: :logout

  get 'revoke_client' => 'clients#revoke', as: :revoke_client
  get 'reactivate_client' => 'clients#reactivate', as: :reactivate_client

  resources :clients, only: [:index, :create, :new, :destroy]
  resources :events, only: [:index, :create, :new, :destroy]
  resources :users, only: [:create, :new, :update]
  resources :admins, only: [:index]

  # API routes
  namespace :api, defaults: { format: :json },
    constraints: { subdomain: 'api' }, path: '/' do
  end
end

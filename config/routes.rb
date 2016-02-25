require 'api_constraints'

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
  namespace :api do
    namespace :v1 do
      resources :users # this isn´t necessary I guess, remember to remove it if not used
      resources :salaries
      resources :tags do
        resources :salaries
      end
      resources :locations
    end
  end

  # namespace :api, defaults: { format: :json },
    # constraints: { subdomain: 'api' }, path: '/' do
    # Versioning through headers. Default version is v1.
    # scope module: :v1,
      # constraints: ApiConstraints.new(version: 1, default: true) do
      # resources :users # this isn´t necessary I guess, remember to remove it if not used
    # end
  # end
end

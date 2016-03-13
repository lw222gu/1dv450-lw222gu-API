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
      post '/auth' => 'sessions#auth'

      resources :salaries, only: [:index, :show, :create, :update, :destroy] do
        resources :tags, only: [:index]
        resources :locations, only: [:index]
      end

      resources :tags, only: [:index, :show, :create] do
        resources :salaries, only: [:index]
      end

      resources :locations, only: [:index, :show, :create] do
        resources :salaries, only: [:index]
      end

      resources :resource_owners, only: [:index, :show, :create] do
        resources :salaries, only: [:index]
      end
    end
  end
end

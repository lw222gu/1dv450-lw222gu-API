Rails.application.routes.draw do
  root 'sessions#new'

  get 'login' => 'sessions#new', as: :login
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy', as: :logout
  
  get 'revoke_client' => 'clients#revoke', as: :revoke_client
  get 'reactivate_client' => 'clients#reactivate', as: :reactivate_client
  
  resources :clients, only: [:index, :create, :new, :destroy]
  resources :users, only: [:create, :new]
  resources :admins, only: [:index]
end

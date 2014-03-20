BoxDay::Application.routes.draw do

  root to: 'users#index'

  resources :users
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  get   'auth/failure', to: redirect('/')

  get 'signout', to: 'sessions#destroy'
end

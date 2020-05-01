Rails.application.routes.draw do
  root      'events#index'
  get       '/signup',   to: 'users#new'
  post      '/signup',   to: 'users#create'
  resources :users,      only: [:show]
  get       '/login',    to: 'sessions#new'
  post      '/login',    to: 'sessions#create'
  delete    '/logout',   to: 'sessions#destroy'
  resources :events,     only: [:index, :new, :create, :show]
end

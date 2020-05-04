Rails.application.routes.draw do
  root      'events#index'
  get       '/signup',                   to: 'users#new'
  post      '/signup',                   to: 'users#create'
  resources :users,                      only: [:show]
  get       'users/:id/attended_events', to: 'users#attended_events'
  get       'users/:id/previous_events', to: 'users#previous_events'
  get       'users/:id/upcoming_events', to: 'users#upcoming_events'
  get       '/login',                    to: 'sessions#new'
  post      '/login',                    to: 'sessions#create'
  delete    '/logout',                   to: 'sessions#destroy'
  resources :events,                     only: [:index, :new, :create, :show]
  get       '/past_events',              to: 'events#past_events'
  get       '/upcoming_events',          to: 'events#upcoming_events'
  get       '/events/:id/invite',        to: 'invitations#new'
  post      '/events/:id/invite',        to: 'invitations#create'
end
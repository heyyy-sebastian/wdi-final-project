Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'
  post '/users', to: 'users#create'

  get '/search', to: 'users#find_artist'
  get '/vote', to: 'users#save_song_votes'

  root to: 'sessions#new'
  resources :users, only: [:index, :create, :new]
end

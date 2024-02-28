Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :tracks
  resources :instruments, only: [:index, :new, :create]
  resources :genres, only: [:index, :new, :create]
  resources :locations, only: [:index, :new, :create]
  get '/index_results/:id', to: 'tracks#index_results', as: 'index_results'
	get '/my_tracks', to: 'tracks#myTracks', as: 'myTracks'
	get '*path', to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end

Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # get '/tracks', to: 'tracks#index', as: 'tracks'
  resources :tracks
  get '/instrus', to: 'instruments#index', as: 'zib'
  get '/genrus', to: 'genres#index', as: 'zub'
  get '/locs', to: 'locations#index', as: 'loc'
  get '/index_results/:id', to: 'tracks#index_results', as: 'index_results'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

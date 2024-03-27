Rails.application.routes.draw do
  devise_for :users,
		controllers: {
			sessions: "users/sessions",
			registrations: "users/registrations"
		}

	namespace :api do
		namespace :v1 do
			resources :chatrooms, only: %i[index] do
				resources :messages, only: %i[index create]
			end
		end
	end
  resources :tracks
  resources :instruments, only: [:index, :new, :create]
  resources :genres, only: [:index, :new, :create]
	root 'tracks#index'
  get '/index_results/:id', to: 'tracks#index_results', as: 'index_results'
	get '/my_tracks', to: 'tracks#myTracks', as: 'myTracks'
	get "/member-data", to: "members#show"
	get "*path", to: "static#index", constraints: proc { |request| !request.xhr? && request.format.html? }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end


Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :listings do 
    resources :results
  end
  get 'about', to: 'pages#about'
  get "dashboard", to: "users#dashboard", as: :dashboard
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

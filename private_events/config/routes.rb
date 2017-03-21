Rails.application.routes.draw do
  root 'static_pages#home'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

  resources :sessions, only: [:new,:create,:destroy]	
  resources :events, only: [:new,:create,:show,:index]
  resources :users, only: [:new,:create,:show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

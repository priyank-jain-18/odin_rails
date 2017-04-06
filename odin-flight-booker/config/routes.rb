Rails.application.routes.draw do
  root 'flights#index'
  resources :flights, only: :index
  resources :passengers, only: :create
  resources :bookings, only: [:new,:create,:show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

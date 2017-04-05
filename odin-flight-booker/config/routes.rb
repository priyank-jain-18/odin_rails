Rails.application.routes.draw do
  root 'flights#index'
  resources :flights, only: :index
  resources :bookmarks, only: :new

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

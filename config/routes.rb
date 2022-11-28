Rails.application.routes.draw do
  root "flights#index"

  devise_for :users

  resources :flights, only: %i[index home]
  resources :bookings, only: %i[index show new create]

  get 'home', to: 'flights#home'
end

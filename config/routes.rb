Rails.application.routes.draw do
  root "flights#index"
  devise_for :users

  resources :flights, only: [:index]
  resources :bookings, only: %i[show new create]
end

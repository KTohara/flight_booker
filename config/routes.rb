Rails.application.routes.draw do
  root "flights#index"
  devise_for :users

  resources :flights, only: [:index]
end

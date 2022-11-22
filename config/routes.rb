Rails.application.routes.draw do
  root "flights#index"
  
  devise_scope :user do
    # Redirests signing out users back to sign-in
    get "users", to: "devise/sessions#new"
  end

  devise_for :users

  resources :flights, only: [:index]
  resources :bookings, only: %i[show new create]
end

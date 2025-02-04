Rails.application.routes.draw do
  get "matches/cat", to: "matches#cat"
  get "matches/random", to: "matches#random"
  resources :matches do
    post :move
  end
  post "matches/new_game", to: "matches#new_game"
  root to: "matches#index"
  resources :stats, only: [:index]
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

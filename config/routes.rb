Rails.application.routes.draw do
  root 'sessions#login'

  resources :tasks

  get "/auth/:provider/callback" =>  "sessions#create"
  get 'sessions/login', to: 'sessions#login', as: 'login'
  delete 'sessions/logout', to: 'sessions#logout', as: "logout"


end

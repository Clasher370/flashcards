Rails.application.routes.draw do
  get 'oauths/oauth'

  get 'oauths/callback'

  resources :user_sessions
  resources :users
  resources :cards

  root to: 'flashcards#index'
  post 'compare' => 'flashcards#compare'

  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout
  get 'signup' => 'users#new', :as => :signup

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
end

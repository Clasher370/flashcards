Rails.application.routes.draw do
  resources :user_sessions
  resources :users
  resources :cards

  root to: 'flashcards#index'
  post 'compare' => 'flashcards#compare'

  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout
  get 'signup' => 'users#new', :as => :signup
end

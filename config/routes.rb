Rails.application.routes.draw do
  scope '(:locale)', locale: /ru|en/ do
    namespace :home do
      resources :users, only: [:new, :create]
      get 'signup' => 'users#new' # , :as => :signup
      get 'login' => 'user_sessions#new' # , :as => :login
    end

    namespace :dashboard do
      resources :users, only: [:edit, :update]
      post 'logout' => 'user_sessions#destroy'
    end

    get 'oauths/oauth'

    get 'oauths/callback'

    resources :user_sessions
    resources :cards
    resources :decks

    root to: 'flashcards#index'
    post 'compare' => 'flashcards#compare'


    post 'oauth/callback' => 'oauths#callback'
    get 'oauth/callback' => 'oauths#callback'
    get 'oauth/:provider' => 'oauths#oauth', :as => :auth_at_provider

    post 'current' => 'decks#current_deck'
  end
end

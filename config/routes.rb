Rails.application.routes.draw do
  scope '(:locale)', locale: /ru|en/ do
    root to: 'dashboard/flashcards#index'

    namespace :home do
      resources :users, only: [:new, :create]
      get 'signup' => 'users#new' # , :as => :signup
      get 'login' => 'user_sessions#new' # , :as => :login
      resources :user_sessions, only: :create
    end

    namespace :dashboard do
      post 'compare' => 'flashcards#compare'
      resources :users, only: [:edit, :update]
      resources :cards, :decks
      post 'logout' => 'user_sessions#destroy' # , :as => :logout
    end

    scope module: 'home' do
      get 'oauths/oauth'
      get 'oauths/callback'
      post 'oauth/callback' => 'oauths#callback'
      get 'oauth/callback' => 'oauths#callback'
      get 'oauth/:provider' => 'oauths#oauth', :as => :auth_at_provider
    end
  end
end

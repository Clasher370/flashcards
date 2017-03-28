Rails.application.routes.draw do
  root to: 'flashcards#index'
  resources :cards, only: :index
end

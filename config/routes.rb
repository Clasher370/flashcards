Rails.application.routes.draw do
  root to: 'flashcards#index'
  match '/', to: 'flashcards#compare', via: :post
  resources :cards
end

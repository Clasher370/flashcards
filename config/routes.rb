Rails.application.routes.draw do
  root to: 'flashcards#index'
  post 'compare' => 'flashcards#compare'
  resources :cards
end

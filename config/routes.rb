Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  
  resources :users
  resources :books
  
  root to: 'books#index'

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end

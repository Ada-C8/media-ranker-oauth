Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get '/login', to: 'welcome#login_form', as: 'login'
  post '/login', to: 'welcome#login'
  get '/logout', to: 'welcome#logout', as: 'logout'

  resources :albums
  post '/albums/:id/upvote', to: 'albums#upvote', as: 'upvote_album'
  resources :books
  post '/books/:id/upvote', to: 'books#upvote', as: 'upvote_book'
  resources :movies
  post '/movies/:id/upvote', to: 'movies#upvote', as: 'upvote_movie'

  resources :users, only: [:index, :show]
end

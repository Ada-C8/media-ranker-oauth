Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get '/login', to: 'welcome#login_form', as: 'login'
  post '/login', to: 'welcome#login'
  get '/logout', to: 'welcome#logout', as: 'logout'

  resources :albums
  resources :books
  resources :movies
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'works#root'
  get '/login', to: 'sessions#login_form', as: 'login'
  post '/login', to: 'sessions#login'
  post '/logout', to: 'sessions#logout', as: 'logout'

  # Build the category routes for albums, books and movies
  # category_constraints = { category: /(albums)|(books)|(movies)/}
  # get '/:category', to: 'works#index', as: 'works', constraints: category_constraints
  # get '/:category/new', to: 'works#new', as: 'new_work', constraints: category_constraints
  # post '/:category', to: 'works#create', constraints: category_constraints

  # Specific works are just referenced by /work/:id
  resources :works
  post '/works/:id/upvote', to: 'works#upvote', as: 'upvote'

  resources :users, only: [:index, :show]
end

Rails.application.routes.draw do
  # get '/search', to: 'posts#search'
  # post '/search', to: 'posts#searching'
  
  get 'sessions/new'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  resources :users
  resources :posts do 
    resource :favorites, only: [:create, :destroy]
  end
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
end

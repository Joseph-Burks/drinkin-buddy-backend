Rails.application.routes.draw do
  post '/interests/remove', to: 'interests#destroy'
  post '/login', to: 'users#log_in'
  get '/get_user', to: 'users#get_user'
  get '/breweries-20', to: 'breweries#first_twenty'
  resources :interests
  resources :reviews
  resources :beers
  resources :breweries
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

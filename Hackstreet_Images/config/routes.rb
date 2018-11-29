Rails.application.routes.draw do
  get 'comment_controller/Comments'
  devise_for :users, :controllers => { registrations: 'registrations' }
  get '/home', to: 'users#home', as: 'home'
  get '/user/:id', to: 'users#show'

  resources :images, :except => [:create] do
    resources :comments
  end
  # resources :images
  # get '/images', to: 'images#index', as: 'images'
  post '/create', to: 'images#create', as: 'create'
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



end

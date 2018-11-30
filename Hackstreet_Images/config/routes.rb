Rails.application.routes.draw do
  get 'comment_controller/Comments'
  devise_for :users, :controllers => { registrations: 'registrations' }
  get '/user/:id', to: 'users#show', as: 'show'
  #added Michael Hemmelgarn
  resource :user, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end


  resources :users

  #added Michael Hemmelgarn
  get :search, controller: :search

  post 'image/:id/favorite', to: 'images#favorite', as: 'fav'
  delete 'image/:id/unfavorite', to: 'images#unfavorite', as: 'unfav'

  #Added by Jalen Soat
  resources :images do#, :except => [:create] do
    resources :comments #, only: [:create, :index, :destroy]
    #resources :favorites, only: [:create, :destroy]
  end

  #Added by Jalen Soat
  resources :users do
    resources :comments
    resources :favorites
  end

  get '/image/new', to: 'images#new', as: 'image_upload'
  # resources :images, :except => [:create]
  # resources :images
  # get '/images', to: 'images#index', as: 'images'
  post '/create', to: 'images#create', as: 'create'
  root 'images#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



end

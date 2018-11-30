Rails.application.routes.draw do
  get 'comment_controller/Comments'
  devise_for :users, :controllers => { registrations: 'registrations' }
  get '/user/:username', to: 'users#show', as: 'show'

  #added by Nick Nitta
  get '/user/:username/followers', to: 'users#followers', as: 'followers'
  get '/user/:username/following', to: 'users#following', as: 'following'

  resources :relationships,       only: [:create, :destroy]

  #added Michael Hemmelgarn
  get :search, controller: :search

  #added by Ivan Lavrov
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
  #added by Ivan Lavrov
  post '/create', to: 'images#create', as: 'create'
  root 'images#index', as: 'root'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  


end

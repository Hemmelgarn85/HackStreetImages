Rails.application.routes.draw do
  get 'comment_controller/Comments'
  devise_for :users, :controllers => { registrations: 'registrations' }
  get '/user/:username', to: 'users#show', as: 'show'

  get '/user/:username/followers', to: 'users#followers', as: 'followers'
  get '/user/:username/following', to: 'users#following', as: 'following'

  resources :relationships,       only: [:create, :destroy]

  #added Michael Hemmelgarn
  get :search, controller: :search


  resources :images do#, :except => [:create] do
    resources :comments #, only: [:create, :index, :destroy]
  end

  resources :users do
    resources :comments
  end

  get '/image/new', to: 'images#new', as: 'image_upload'

  post '/create', to: 'images#create', as: 'create'
  root 'images#index', as: 'root'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  


end

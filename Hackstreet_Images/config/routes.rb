Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  get '/user/:username', to: 'users#show'
  #added Michael Hemmelgarn
  resource :user, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end

  get '/image/new', to: 'images#new', as: 'image_upload'
  resources :images, :except => [:create]
  # resources :images
  # get '/images', to: 'images#index', as: 'images'
  post '/create', to: 'images#create', as: 'create'
  root 'images#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

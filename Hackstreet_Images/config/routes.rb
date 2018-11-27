Rails.application.routes.draw do
  
  devise_for :users
  resources :images, :except => [:create]
  # resources :images
  # get '/images', to: 'images#index', as: 'images'
  post '/create', to: 'images#create', as: 'create'
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

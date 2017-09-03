Rails.application.routes.draw do

  devise_for :users
  
  resources :users, only: [ :show, :edit, :update, :index] do
  	resource :relationships, only: [ :create, :destroy]
  	get :favorites, on: :member
  	get :follows, on: :member
  	get :followers, on: :member
  end
  resources :posts do 
  	resource :favorites, only: [:create, :destroy]
  end

  root "home#top"
  get 'home/about'

  resources :users,only: [:show, :index] do
    resource :relationships, only: [ :create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end

  resources :posts do 
    resource :comments, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

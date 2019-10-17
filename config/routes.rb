Rails.application.routes.draw do
  get 'users/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#top'
  get 'home/top' => 'home#top'
  get 'home/search' => 'home#search' 
  get 'home/about' => 'home#about'

  get 'articles/search' => 'articles#search'
  get "users/:id/likes" => "users#likes"
  get "articles/:id/likes" => "articles#likes"

  resources :articles, only: [:create, :index, :new, :show, :edit, :update, :destroy]do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 

  devise_scope :user do
    get "log_in", :to => "users/sessions#new"
    get "log_out", :to => "users/sessions#destroy" 
  end
  
  get "users/show/:id" => "users#show"
  resources :users
end

Rails.application.routes.draw do

  resources :collaborators, only: [:new, :create, :destroy]

  resources :wikis

  get 'about' => 'welcome#about'
  
  resources :charges, only: [:new, :create, :destroy]

  devise_for :users
  
  root "welcome#index"
end

Rails.application.routes.draw do

  devise_for :users
root to: "get#index"
end

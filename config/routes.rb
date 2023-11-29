Rails.application.routes.draw do
 
  namespace :users do
    get 'ingredients/new'
    get 'ingredients/show'
    get 'ingredients/edit'
  end
  namespace :users do
    get 'genres/new'
    get 'genres/index'
    get 'genres/show'
    get 'genres/edit'
  end
  
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
end

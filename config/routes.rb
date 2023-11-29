Rails.application.routes.draw do
 
  namespace :users do
    get 'genres/new'
    get 'genres/index'
    get 'genres/show'
    get 'genres/edit'
  end
  get 'genres/new'
  get 'genres/index'
  get 'genres/show'
  get 'genres/edit'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
end

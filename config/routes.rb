Rails.application.routes.draw do
 
  # namespace :users do
  #   get 'ingredients/new'
  #   get 'ingredients/show'
  #   get 'ingredients/edit'
  # end
  # namespace :users do
  #   get 'genres/new'
  #   get 'genres/index'
  #   get 'genres/show'
  #   get 'genres/edit'
  # end
  
  scope module: :users do
    resources :ingredients do
      resources :comments, only: [:create, :update]
    end
    resources :genres, except: [:new]
  end
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  
  #検索機能
  get "search" => "searches#search"
end

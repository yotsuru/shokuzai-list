Rails.application.routes.draw do
 
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  scope module: :users do
    resources :ingredients do
      resources :comments, only: [:create, :update]
    end
    resources :genres, except: [:new]
    get 'users/mypage' => 'users#show'
    get 'users/mypage/edit' => 'users#edit'
    patch 'users/mypage' => 'users#update', as: 'update_user'
    
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  
  #検索機能
  get "search" => "searches#search"
  get "search_by_date" => "searches#search_by_date"
end

Rails.application.routes.draw do
  root 'home#index'
  get 'home/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users, :controllers => {
  :registrations => 'users/registrations',
  :sessions => 'users/sessions'   
} 

  devise_scope :user do
    get "user/:id", :to => "users/registrations#detail"
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    get "logout", :to => "users/sessions#destroy"
  end

  resources :users, only: [:show]
  resources :posts, shallow: true do
    resource :bookmarks, only: [:create, :destroy]
  end
  resources :comments, only: %i[create destroy]
  resources :categorys, only: [:index, :show]
end

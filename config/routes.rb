Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:show, :index, :edit, :update, :destroy]
  get '/mypage', to: 'users#mypage', as: 'mypage'
  resources :posts
  resources :car_models, only: [:new, :create, :edit, :update, :destroy]
  resources :driving_distances, only: [:new, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  get '/homes/about', to: 'homes#about', as: 'about'
  get "/search", to: "searches#search", as: "search"

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
end

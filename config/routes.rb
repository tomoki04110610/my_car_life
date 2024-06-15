Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:show, :index, :edit, :update]
  get '/mypage', to: 'users#mypage', as: 'mypage'
  resources :posts
  resources :car_models, only: [:new, :create, :edit, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  get '/homes/about', to: 'homes#about', as: 'about'
end

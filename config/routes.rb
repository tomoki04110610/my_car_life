Rails.application.routes.draw do

  root to: "public/homes#top"

    devise_scope :user do
      post "users/guest_sign_in", to: "public/guest_user/sessions#guest_sign_in"
    end
    devise_for :users, controllers: {
      sessions: 'public/sessions',
      registrations: 'public/registrations'
    }

  scope module: :public do
    get "/mypage", to: "users#mypage", as: "mypage"
    get '/homes/about', to: "homes#about", as: "about"
    get "/search", to: "searches#search", as: "search"
    resources :users, only: [:show, :index, :edit, :update, :destroy]
    resources :posts, except: [:new]
      resources :post_comments, only: [:create, :destroy]
    resources :car_models, only: [:new, :create, :edit, :update, :destroy]
    resources :driving_distances, only: [:new, :create]
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html



  end

  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get "dashboards", to:"dashboards#index"
    resources :users, only: [:destroy]
    resources :posts, only: [:index, :show]
    resources :post_comments, only: [:destroy]
    resources :genres, only: [:new, :create, :index, :destroy]
  end

end

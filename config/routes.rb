Rails.application.routes.draw do
  root   "static_pages#home"
  get    "/help",    to: "static_pages#help"
  get    "/about",   to: "static_pages#about"
  get    "/contact", to: "static_pages#contact"
  get    "/signup",  to: "users#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  get    "/search",  to: "search#index"
  get    "/search_users",  to: "users#search"

  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy, :show]
  resources :relationships,       only: [:create, :destroy]
  resources :comments,            only: [:create, :destroy]

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :microposts do
    resources :likes
  end

  resources :microposts do
    resources :comments
  end
end
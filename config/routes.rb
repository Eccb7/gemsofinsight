Rails.application.routes.draw do
  get 'hello_world', to: 'hello_world#index'
  namespace :admin do
    resources :gem_blog_categories do
      resources :posts
    end
    resources :orders
    resources :products do
      resources :stocks
    end
      resources :categories
  end
  devise_for :admins
  # devise_for :user
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"

  authenticated :admin_user do
    root to: "admin#index", as: :admin_root
  end

  resources :categories, only: [:show, :index]
  resources :products, only: [:show]
  resources :posts

  get "admin" => "admin#index"
  get "cart" => "carts#show"
  post "checkout" => "checkouts#create"
  get "success" => "checkouts#success"
  get "cancel" => "checkouts#cancel"
  post "webhooks" => "webhooks#stripe"
  get "blogs" => "blogs#index"
end

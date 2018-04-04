include SessionsHelper

Rails.application.routes.draw do
  
  get 'traids/recent_traid_locations'=> "traids#recent_traid_locations", as: "recent_traid_locations"
  resources :traid_logs
  resources :traids
  post 'traids/accept' => "traids#accept", as: "accept_traid"
  post 'traids/cancel' => "traids#cancel", as: "cancel_traid"
  get 'welcome/index'

  # Sessions paths
  get "/sign_in" => "sessions#new", as: "sign_in"
  post "/sign_in" => "sessions#create"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  
  # Google Login Paths - Not sure if this is required?
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  
  # Welcome page
  get "/" => "welcome#index"
  root :to => "welcome#index"
  
  # Resources
  resources :users do
    resources :reviews, only: [:new, :create, :destroy]
  end
  get "/users/recent_user_addresses" => "users#recent_user_addresses", as: "recent_user_addresses_path"
  
  resources :search, only: [:index]
  post "/search" => "search#search"
  
  resources :notifications, only: [:destroy]
  
end

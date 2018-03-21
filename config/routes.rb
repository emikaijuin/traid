include SessionsHelper

Rails.application.routes.draw do
  

  get 'welcome/index'

  # Sessions paths
  get "/sign_in" => "sessions#new", as: "sign_in"
  post "/sign_in" => "sessions#create"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  
  # Welcome page
  get "/" => "welcome#index"
  root :to => logged_in? ? "welcome#index" : "users#index"
  
  # Resources
  resources :users
  
end

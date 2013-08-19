Nimbos::Engine.routes.draw do

  get "logout" => "sessions#destroy", :as => "logout"
  get "login"  => "sessions#new", :as => "login"
  get "signup" => "patrons#new", :as => "signup"

  resources :sessions
  resources :password_resets
  resources :posts do
    resources :comments
  end

  resources :patrons
  resources :branches
  resources :users do
    member do
      get :activate, :activation, :follow
    end
    collection do
      get :invite_coworkers
    end
    collection do
      put  :create_coworkers
    end
  end
  resources :reminders
  resources :tasks
  resources :todolists

  resources :listheaders
  resources :listitems
  resources :countries
  resources :currencies

  #root :to => "posts#index"
  
end

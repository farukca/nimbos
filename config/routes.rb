Nimbos::Engine.routes.draw do

  concern :commentable do
    resources :comments
  end
  # concern :discussable do
  #   resources :discussions
  # end
  # concern :tasked do
  #   resources :todolists
  # end

  get "logout" => "sessions#destroy", as: "logout"
  get "login"  => "sessions#new", as: "login"
  get "signup" => "patrons#new", as: "signup"
  get "register" => "users#new", as: "register"
  get "dashboard" => "dashboard#index", as: "dashboard"
  get "calendar"  => "dashboard#calendar", as: "calendar"
  get "setup" => "setup#new", as: "setup"
  get "start" => "setup#start", as: "start"

  resources :sessions
  resources :password_resets

  resources :comments
  resources :posts, concerns: :commentable
  resources :discussions, concerns: :commentable
  resources :groups

  resources :patrons do
    member do
      get :jump
    end
  end
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

  resources :activities
  resources :reminders
  #resources :tasks
  resources :todolists do
    resources :tasks
  end
  resources :tasks, concerns: :commentable

  resources :listheaders
  resources :listitems
  resources :countries
  resources :currencies
  resources :counters

  #root :to => "posts#index"
  
end

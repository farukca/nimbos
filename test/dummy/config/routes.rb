Rails.application.routes.draw do

  resources :feedbacks

  resources :betausers

  root :to => "home#index"
  
  %w[roadmap security features services aboutus].each do |page|
    get page, controller: "home", action: page
  end


  mount Nimbos::Engine => "/nimbos"
end

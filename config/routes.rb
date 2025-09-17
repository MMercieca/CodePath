Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  get "/dashboard", to: "dashboard#index"
  resources :lectures do
    post  'lectures', to: 'lectures#create'
    patch 'lectures', to: 'lectures#update'
    delete 'lectures', to: 'lectures#delete'
    get   'lectures', to: 'lectures#show'
  end

  resources :assignments do
    get   'assignment', to: 'assignments#show'
  end

  post "/assignments/:id/update", to: "assignments#update"
  get "/assignments/:id/edit", to: "assignments#edit"
  get "/lectures/:id/assignments/new", to: "lectures#create_assignment"

  root "home#index"
end

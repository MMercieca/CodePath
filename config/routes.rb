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
  root "home#index"
end

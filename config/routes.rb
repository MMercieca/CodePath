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

  post "/lectures/:id/update", to: "lectures#update"
  post "/lectures/:id/delete", to: "lectures#delete"
  get "/lectures/:id/add_students", to: "lectures#show_add_students"
  post "/lectures/:id/add_students", to: "lectures#add_students"
  get "/lectures/:id/students/:student_id/remove", to: "lectures#remove_student"
  
  resources :assignments do
    get   'assignment', to: 'assignments#show'
  end

  post "/assignments/:id/update", to: "assignments#update"
  post "/assignments/:id/delete", to: "assignments#delete"
  get "/assignments/:id/supporting_documents/:file_id/delete", to: "assignments#delete_supporting_document"
  get "/assignments/:id/edit", to: "assignments#edit"
  get "/lectures/:id/assignments/new", to: "lectures#create_assignment"

  root "home#index"
end

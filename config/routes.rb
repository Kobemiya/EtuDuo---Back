Rails.application.routes.draw do
  resources :tasks
  get '/user', to: "user#index"
  post '/user', to: "user#create"
  delete '/user', to: "user#destroy"
  put '/user', to: "user#update"
  patch '/user', to: "user#update"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  scope :tasks do
    resources :tags
  end
  resources :tasks
  get '/user', to: "user#index"
  post '/user', to: "user#create"
  delete '/user', to: "user#destroy"
  put '/user', to: "user#update"
  patch '/user', to: "user#update"
  get '/profile', to: "profile#index"
  put '/profile', to: "profile#update"
end

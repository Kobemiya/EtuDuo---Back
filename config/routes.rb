Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  scope :tasks do
    resources :tags
    post '/tags/global', to: "tags#global_create"
  end

  resources :tasks

  resources :accessories

  get '/user', to: "user#index"
  post '/user', to: "user#create"
  delete '/user', to: "user#destroy"
  put '/user', to: "user#update"
  patch '/user', to: "user#update"

  get '/profile', to: "profile#index"
  put '/profile', to: "profile#update"

  get '/inventory', to: "inventory#index"
  put '/inventory/:accessory_id', to: "inventory#add_accessory"
  delete '/inventory/:accessory_id', to: "inventory#remove_accessory"

  get '/companion', to: "companion#index"
  put '/companion', to: "companion#update"
end

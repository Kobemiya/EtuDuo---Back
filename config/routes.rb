Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  scope :tasks do
    resources :tags
    post '/tags/global', to: "tags#global_create"
  end

  resources :tasks

  resources :accessories

  resources :rooms

  post '/rooms/enter/:room_id', to: "rooms#enter_room"
  post '/rooms/leave/:room_id', to: "rooms#leave_room"

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
  put '/companion/:accessory_id', to: "companion#equip_accessory"
  delete '/companion/:accessory_id', to: "companion#unequip_accessory"

  get '/achievements', to: "achievements#index"
  post '/achievements', to: "achievements#create"
  get '/achievements/:id', to: "achievements#show"
  put '/achievements/:id', to: "achievements#update"
  patch '/achievements/:id', to: "achievements#update"
  delete '/achievements/:id', to: "achievements#destroy"
  post '/achievements/:id/grant', to: "achievements#grant"
  get '/user/achievements', to: "achievements#user_achievements"
end

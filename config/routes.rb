Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  root 'item#index'
  get 'show' => 'item#show'

# config/routes.rb
resources :carts do
  resources :cart_items, only: [:destroy]
end

resources :carts do
  delete 'remove_item/:cart_item_id', to: 'carts#remove_item', as: 'remove_item', on: :member
end

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

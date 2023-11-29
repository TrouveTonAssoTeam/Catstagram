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

  scope '/payment' do
    post 'create', to: 'payment#create', as: 'checkout_create'
    get 'success', to: 'payment#success', as: 'checkout_success'
    get 'cancel', to: 'payment#cancel', as: 'checkout_cancel'

    # Only for testing
    get 'new', to: 'payment#new', as: 'checkout_new'
  end

  # Profile page and edit
  get 'profile', to: 'profile#show', as: 'profile'
  scope '/profile'  do
    get 'edit', to: 'profile#edit', as: 'profile_edit'
    post 'update', to: 'profile#update', as: 'profile_update'
  end

  get '/how_it_works', to: 'pages#how_it_works'
  get '/contact', to: 'pages#contact'
  get '/about', to: 'pages#about'
  
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

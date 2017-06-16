Rails.application.routes.draw do

  get 'order_items/create'

  get 'order_items/update'

  get 'order_items/destroy'

  get 'carts/show'

  get 'def/destroy'
  
  root 'pages#home'

  devise_for :users,
  			 :path => '', 
  			 :path_names => {:sign_in => 'login', :sign_out => 'logout', :edit => 'profile'},
  			 :controllers => {:omniauth_callbacks => 'omniauth_callbacks', :registrations => 'users/registrations'}

  resources :users, only: [:show]
  resources :products
  resources :product_photos
  resources :user_photos

  resource :cart, only: [:show]
  resources :order_items, only: [:create, :update, :destroy]

end

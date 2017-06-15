Rails.application.routes.draw do

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

end

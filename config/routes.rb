Rails.application.routes.draw do
  get 'carts/show'
  get 'top/main'
  resources :products
  root 'top#main'
  resources :cartitems, only: [:new, :create, :destroy]
  resources :carts, only: [:show]
end

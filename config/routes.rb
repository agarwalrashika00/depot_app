Rails.application.routes.draw do
  resources :line_items
  resources :carts
  # get 'store/index'
  resources :products
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "store#index", as: 'store_index'
  get "/products", to: "products#index"
end

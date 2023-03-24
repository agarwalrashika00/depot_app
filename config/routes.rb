Rails.application.routes.draw do
  get 'admin' => 'admin#index'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  # get 'admin/index'
  # get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :users
  resources :orders
  resources :line_items
  resources :carts
  # Defines the root path route ("/")
  root "store#index", as: 'store_index'

  # get 'store/index'
  resources :products do
    get :who_bought, on: :member
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  
  get "/products", to: "products#index"
end

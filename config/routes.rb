Rails.application.routes.draw do
  get 'admin' => 'admin#index'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :categories

  # get 'admin/index'
  # get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  get "/users/orders", to: "users#show_orders"
  get "/users/line_items", to: "users#show_line_items"
  resources :users

  # Defines the root path route ("/")

  # get 'store/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :line_items
  scope '(:locale)' do
    resources :orders
    resources :carts
    resources :products do
      get :who_bought, on: :member
    end
    root "store#index", as: 'store_index', via: :all
  end
  get "/products", to: "products#index"
end

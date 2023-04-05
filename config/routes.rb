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
end

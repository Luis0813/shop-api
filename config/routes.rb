Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :product, only: [ :index, :show, :create, :update  ]
  # Defines the root path route ("/")
  # root "posts#index"
  resources :session, only: [ :edit, :create ]
  resources :products do
     resource :product_images, only: [ :show, :create ]
  end
end

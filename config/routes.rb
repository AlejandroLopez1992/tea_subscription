Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :customer_subscriptions, only: [:create, :index]
      patch "/customer_subscriptions_cancel", to: "customer_subscriptions#update"
    end
  end
end

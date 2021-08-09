Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  namespace :api do
    namespace :v1 do

      resources :loads
      resources :products

      resources :orders, only: [:show, :update, :destroy] do
        resources :order_products, except: [:show]
        resources :sorted_order_products, only: [:index]
      end

    end
  end
end
Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users
  namespace :api do
    namespace :v1 do
      resources :loads do
        resources :orders, only: [:create, :index]
      end
      resources :products
      resources :orders, only: [:show, :update, :destroy] do
        resources :order_products, except: [:show]
        resources :sorted_order_products, only: [:index]
      end
      get '/orders/:id/sorted', to: 'orders#show_sorted'
      post '/imports/csv', to: 'imports#csv'
    end
  end
end
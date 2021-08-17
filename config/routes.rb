Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  
  post '/import', to: 'import_records#import'
 end
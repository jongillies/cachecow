CacheCow::Application.routes.draw do

  authenticated :user do
    root :to => 'home#index'
  end

  root :to => "home#index"

  devise_for :users
  resources :users, :only => [:show, :index]

  resources :subscribers
  resources :crops
  resources :subscriptions
  resources :changes
  resources :harvests
  resources :transactions
  resources :deliveries

end

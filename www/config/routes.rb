Www::Application.routes.draw do

  resources :subscribers
  resources :crops
  resources :subscriptions
  resources :changes
  resources :harvests
  resources :transactions
  resources :deliveries

  root :to => 'welcome#index'

end

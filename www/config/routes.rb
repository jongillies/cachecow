Www::Application.routes.draw do

  resources :subscribers
  resources :crops
  resources :subscriptions
  resources :change_logs
  resources :harvester_logs
  resources :transaction_logs

  # root :to => 'welcome#index'

end

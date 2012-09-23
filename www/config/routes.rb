Www::Application.routes.draw do

  resources :subscribers
  resources :crops
  resources :subscriptions


  # root :to => 'welcome#index'

end

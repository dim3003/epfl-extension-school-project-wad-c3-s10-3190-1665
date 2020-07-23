Rails.application.routes.draw do

  root to: 'home#index'

  resources :users
  
  resources :pins do
    resources :comments
  end
end

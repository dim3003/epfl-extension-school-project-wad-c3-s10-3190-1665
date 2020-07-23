Rails.application.routes.draw do

  get 'account/mypins'

  root to: 'home#index'

  resources :users
  
  resources :pins do
    resources :comments
  end
end

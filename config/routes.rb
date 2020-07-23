Rails.application.routes.draw do

  root to: 'home#index'

  resources :users do
    resources:goals
  end

  resources :pins do
    resources :comments
  end

  get 'account/mypins', to: 'account#mypins', as: 'account'

end

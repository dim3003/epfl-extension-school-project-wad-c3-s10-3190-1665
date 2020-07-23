Rails.application.routes.draw do

  get 'account/mypins'

  root to: 'home#index'

  resources :users

  resources :pins do
    resources :comments
  end

  get 'account/mypins', to: 'account#mypins', as: 'account'

end

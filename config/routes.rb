Rails.application.routes.draw do

  get 'pins/edit'

  get 'pins/index'

  get 'pins/new'

  get 'pins/show'

  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

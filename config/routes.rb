Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # namespaceを使用しadminディレクトリにまとめる
  namespace :admin do
    resources :users
  end
  root to: 'tasks#index'
  resources :tasks do
    post :confirm, action: :confirm_new, on: :new
    # on: :collectionでidを含めない
    post :import, on: :collection
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

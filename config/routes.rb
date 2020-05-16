Rails.application.routes.draw do
  # namespaceを使用しadminディレクトリにまとめる
  namespace :admin do
    resources :users
  end
  root to: 'tasks#index'
  resources :tasks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

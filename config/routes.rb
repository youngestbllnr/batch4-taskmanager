Rails.application.routes.draw do

  root 'main#index'

  get 'dashboard' => 'main#dashboard', as: 'dashboard'
  get 'dev-mode' => 'main#dev', as: 'dev'


  devise_for :users, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "signup" }

  resources :tasks
  resources :categories
  
end

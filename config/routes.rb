Rails.application.routes.draw do

  root 'main#index'

  get 'dashboard' => 'main#dashboard', as: 'dashboard'
  get 'dev-mode' => 'main#dev', as: 'dev'


  devise_for :users, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "signup" }

  devise_scope :user do
    get 'forgot-password'    => 'devise/passwords#new'
    get 'change-password'    => 'devise/passwords#edit'
  end

  resources :tasks
  resources :categories
  
end

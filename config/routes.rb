Rails.application.routes.draw do

  root 'main#index'

  get 'index' => 'main#index', as: 'index'
  get 'dashboard' => 'main#dashboard', as: 'dashboard'
  get 'today' => 'main#today', as: 'today'

  get 'toggle-task' => 'tasks#toggle_status', as: 'toggle_task'

  devise_for :users, :path => '', 
                     :path_names => { :sign_in => "login", :sign_up => "signup" }, 
                     :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }

  devise_scope :user do
    get 'signout'    => 'devise/sessions#destroy'
    get 'forgot-password'    => 'devise/passwords#new'
    get 'change-password'    => 'devise/passwords#edit'
  end
  
  resources :categories do
    resources :tasks
  end
  
end

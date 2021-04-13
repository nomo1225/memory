Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to:          'sessions#new'
  post 'login', to:         'sessions#create'
  delete 'logout', to:      'sessions#destroy'
  
  get 'signup', to:          'users#new'
  get 'forget', to:          'users#forget'
  post 'forget', to:         'users#forget_mail'
  get 'reset_password', to:  'users#reset_password'
  post 'reset_password', to: 'users#run_reset'
  resources :users, only: [:show, :create, :edit, :update, :destroy]
  resources :memories
  resources :photos
end

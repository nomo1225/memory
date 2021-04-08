Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'signup', to:          'users#new'
  get 'forget', to:          'users#forget'
  post 'forget', to:         'users#forget_mail'
  get 'reset_password', to:  'users#reset_password'
  post 'reset_password', to: 'users#run_reset'
  resources :users, only: [:index, :show, :create, :edit, :update, :destroy]
end

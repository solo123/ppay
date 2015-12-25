Rails.application.routes.draw do


  get 'profile/info'

  get 'home/index'
  get 'home/profile'

  get 'import/do_import'
  get 'import/do_import1'
  get 'import/parse_data'
  get 'import/get_import_msg'
  get 'import/get_log_msg'
  get 'download/import_xls'

  get 'users/sign_up', to: 'home#index'

  resources :users
  resources :agents
  devise_for :users

  # agent data
  resources :clients
  resources :contacts
  resources :addresses
  resources :salesmen
  resources :pos_machines

  # raw data
  resources :imp_ops
  resources :imp_logs
  resources :imp_qf_clearings
  resources :imp_qf_trades
  resources :imp_qf_customers
  resources :data_manage

  root to: 'home#index'

  # comfy_route :cms_admin, :path => '/cms-admin'
  # comfy_route :cms, :path => '/', :sitemap => false

end

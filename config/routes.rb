Rails.application.routes.draw do
  devise_for :users
  # :users必须在devise_for后面定义 bugfix:把user当作资源的话确保路由通过devise验证
  resources :users

  get 'home/index'
  get 'home/profile'
  get 'download/import_xls/:name', to: 'download#import_xls', as: :download_import_xls

  resources :salesman_day_tradetotals
  resource :report do
    collection do
      get :clients_days
      get :new_clients
      get :active_clients
      get :active_agents
      get :home_summary
    end
  end
  resources :jobs do
    collection do
      get 'run_job/:job', action: :run_job, as: :run_job
      get 'recal'
    end
  end
  resources :notices
  resources :joinlast_clients
  resources :sales_commissions do
    collection do
      get :agents
    end
  end
  resources :bank_cards
  resources :companies
  resources :agents do
    member do
      get :create_login
      get :del_login
      get :del_salesman
      get :add_salesman
      get :active_clients
      get :active_salesmen
    end
    resources :contracts
    resources :contacts
    resources :sales_commissions
  end
  resources :clients do
    member do
      post :tags
      get :tags
      post :note
      get :note
    end
  end
  resources :client_notes
  resources :trades do
    collection do
      get 'client_trades/:client_id', to: 'trades#client_trades'
    end
  end
  resources :clearings
  resources :contacts
  resources :addresses
  resources :salesmen do
    member do
      get :set_client
    end
  end
  resources :pos_machines

  # raw data
  resources :imp_ops
  resources :imp_logs do
    member do
      get :import, :unimport, :total, :untotal
    end
  end
  resources :imp_qf_clearings
  resources :imp_qf_trades
  resources :imp_qf_customers
  resources :code_tables
  resource :summary do
    member do
      get :home_sum
    end
  end
  resources :logs do
    collection do
      get :get_log_msg
    end
  end
  resources :contracts do
    resources :profit_ladders
  end
  resources :profit_ladders

  root to: 'home#index'

  # comfy_route :cms_admin, :path => '/cms-admin'
  # comfy_route :cms, :path => '/', :sitemap => false
end

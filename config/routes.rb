Rails.application.routes.draw do



  # 异步请求活跃数据
  get 'activeinfo/client'
  get 'activeinfo/agent'
  get 'activeinfo/month_sum'
  get 'activeinfo/new_client'

  get 'profile/info'

  get 'home/index'
  get 'home/profile'

  # 数据操作
  get 'import/do_import'
  get 'import/do_import1'
  get 'import/parse_data'
  get 'import/get_import_msg'
  get 'import/get_log_msg'
  get 'import/trades_totals'
  get 'download/import_xls/:name', to: 'download#import_xls', as: :download_import_xls

  devise_for :users
  # :users必须在devise_for后面定义 bugfix:把user当作资源的话确保路由通过devise验证
  resources :users

  # 业务数据
  resources :bank_cards
  resources :companies
  resources :statistic_agents
  resources :statistic_clients
  resources :statistic_trades
  resources :agents do
    member do
      post :del_salesman
      post :add_salesman
    end
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
  resources :trades
  resources :clearings
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
  resources :trades_totals
  resources :trades_total_mons

  root to: 'home#index'

  # comfy_route :cms_admin, :path => '/cms-admin'
  # comfy_route :cms, :path => '/', :sitemap => false

end

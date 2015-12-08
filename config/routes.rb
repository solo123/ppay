Rails.application.routes.draw do

  resources :imp_logs
  get 'upload_report/import'
  get 'upload_report/check'

  devise_for :users
  resources :imp_qf_clearings
  resources :imp_qf_trades
  resources :imp_qf_customers


  comfy_route :cms_admin, :path => '/cms-admin'

  # Make sure this routeset is defined last
  comfy_route :cms, :path => '/', :sitemap => false

end

Rails.application.routes.draw do

  root 'upload_report#check'
  resources :imp_logs
  get 'upload_report/import'
  get 'upload_report/check'

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    omniauth: 'users/omniauth',
    password: 'users/password',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }

  resources :imp_qf_clearings
  resources :imp_qf_trades
  resources :imp_qf_customers


  comfy_route :cms_admin, :path => '/cms-admin'

  # Make sure this routeset is defined last
  comfy_route :cms, :path => '/', :sitemap => false

end

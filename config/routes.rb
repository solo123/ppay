Rails.application.routes.draw do

  get 'trades/index'

  root to: 'home#index'
  resources :imp_logs
  get 'upload_report/import'
  get 'upload_report/check'

  devise_for :users

  devise_scope :user do
    get 'users/sign_out', to: "devise/sessions#destroy"
    get "sign_in", to: "devise/sessions#new"
    get 'sign_up', to: 'devise/passwords#new'
  end

  resources :imp_logs
  resources :imp_qf_clearings
  resources :imp_qf_trades
  resources :imp_qf_customers
  resources :home

  # comfy_route :cms_admin, :path => '/cms-admin'
  # Make sure this routeset is defined last
  # comfy_route :cms, :path => '/', :sitemap => false

end

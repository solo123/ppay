Rails.application.routes.draw do


  resources :home

  get 'upload_data/import'

  devise_for :users
  devise_scope :user do
    get 'users/sign_out', to: "devise/sessions#destroy"
    get "sign_in", to: "devise/sessions#new"
    get 'sign_up', to: 'devise/passwords#new'
  end

  resources :imp_ops
  resources :imp_logs
  resources :imp_qf_clearings
  resources :imp_qf_trades
  resources :imp_qf_customers

  root to: 'home#index'

  comfy_route :cms_admin, :path => '/cms-admin'
  comfy_route :cms, :path => '/', :sitemap => false

end

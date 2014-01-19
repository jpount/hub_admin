HubAdmin::Application.routes.draw do

  mount RailsAdmin::Engine => '/database', :as => 'rails_admin'
  #devise_for :users
  
  #
  # home page
  #
  root :to => "admin#index"
  get 'admin/index' => 'admin#index'
  # Start the run
  post 'admin/launch' => 'admin#launch'

  #
  # Config
  #
  resources :confs

  #
  # FIs
  #
  resources :fis

  # ping from the FI
  post 'admin/ping/:id' => 'fis#ping', :constraints => { :id => /[^\/]+/ }
  post 'admin/metrics/deleteall' => 'fis#delete_all'

  # gets the data from nimbus
  get 'admin/stats' => 'stats#index'

  get 'fimetrics' => 'fi_metrics#index'
  post 'admin/fimetrics' => 'fi_metrics#ping'
  get 'admin/fimetrics/deleteall' => 'fi_metrics#delete_all'
  get 'admin/fimetrics/reset' => 'fi_metrics#reset_fi_metrics'

  #
  # APIs
  #
  resources :apis

  post 'admin/apiregister' => 'apis#register', :constraints => { :url => /[^\/]+/ }
  post 'admin/apis/deleteall' => 'apis#delete_all'

  #
  # Metrics
  #
  post 'admin/apimetrics' => 'api_metrics#ping'
  get 'apimetrics/deleteall' => 'api_metrics#delete_all'
  get 'apimetrics/reset' => 'api_metrics#reset_api_metrics'

  get 'apimetrics' => 'api_metrics#index'
  get 'apimetrics/008' => 'api_metrics#chartpacs008'
  get 'apimetrics/002' => 'api_metrics#chartpacs002'
  get 'apimetrics/lb' => 'api_metrics#lb'

  #
  # Cassie
  #
  get "admin/cassie" => 'cassie#index'
  get "admin/cassie/transactions" => 'cassie#transactions'
  get "admin/cassie/transaction_errors" => 'cassie#transaction_errors'
  post "admin/cassie/connect" => 'cassie#connect'
  post "admin/cassie/search" => 'cassie#search'
  post "admin/cassie/edit_008" => 'cassie#edit_008'
  post "admin/cassie/update_008" => 'cassie#update_008'

  #
  # HAP
  #
  get 'hapstats' => 'lb_metrics#stats'

  #
  # Dashboard
  #
  get 'lb_stats' => 'dashboards#lb_stats'
  get 'total_008_in' => 'dashboards#get_008_in_count'
  get 'total_008_out' => 'dashboards#get_008_out_count'
  get 'total_002_in' => 'dashboards#get_002_in_count'
  get 'total_002_out' => 'dashboards#get_002_out_count'

end

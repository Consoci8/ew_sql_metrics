Rails.application.routes.draw do
  resources :sql_metrics, :only => [:index, :destroy]
end
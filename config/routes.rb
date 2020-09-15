Rails.application.routes.draw do
  resources :calls, :path => "admin/calls"
  resources :cities, :path => "admin/cities/"
  get 'call/:id', to: 'calls#show', as: 'showcall'
  devise_for :users, controllers: { registrations: "registrations" }
  # devise_for :users
  root to: 'pages#home'
  get '/calls/takecall/:id', to: 'calls#takecall', as: 'takecall'
  get '/mycard', to: 'pages#show', as: 'mypdf'
  get '/testcard', to: 'pages#volcard'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

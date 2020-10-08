Rails.application.routes.draw do
  resources :help_options, path: "admin/help_option"
  resources :regions, path: "admin/region"
  resources :calls, path: "admin/calls"
  resources :cities, path: "admin/cities/"
  resources :users, path: "admin/users/"
  get '/newcall', to: 'calls#new', as: 'newcall'
  post '/newcall', to: 'calls#create', as: 'postcall'
  get 'call/:id', to: 'calls#show', as: 'showcall'
  devise_scope :user do
    match '/users/sign_up' => 'devise/registrations#create', as: :account_create, via: [:post]
  end
  devise_for :users
  root to: 'pages#home'
  get '/calls/takecall/:id', to: 'calls#takecall', as: 'takecall'
  get '/calls/markdone/:id', to: 'calls#markdone', as: 'callmarkdone'
  post '/calls/adminmark', to: 'calls#adminmarkdone', as: 'adminmarkdone'
  get 'admin/callsnews', to: 'calls#overview', as: 'overviewcall'
  get '/mycard', to: 'pages#show', as: 'mypdf'
  # get '/testcard', to: 'pages#volcard' # PDF PREVIEW
  get '/admin', to: 'pages#adminpanel', as: 'adminpanel'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

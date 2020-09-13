Rails.application.routes.draw do
  resources :calls
  devise_for :users
  root to: 'pages#home'
  get '/calls/takecall/:id', to: 'calls#takecall', as: 'takecall'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

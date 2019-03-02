Rails.application.routes.draw do
  root to: 'events#index'
  resources :readings
  resources :reports
  resources :sessions
  resources :groups
  resources :events
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

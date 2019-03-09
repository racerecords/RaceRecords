Rails.application.routes.draw do
  namespace :admin do
      resources :events
      resources :groups
      resources :readings
      resources :reports
      resources :sessions

      root to: "events#index"
    end
  root to: 'events#index'
  resources :readings
  resources :reports
  resources :sessions
  resources :groups
  resources :events
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

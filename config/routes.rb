Rails.application.routes.draw do
  namespace :admin do
      resources :users
      resources :events
      resources :groups
      resources :readings
      resources :sessions

      root to: "users#index"
    end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  root to: 'events#index'
  resources :readings
  resources :sessions
  resources :groups
  resources :events
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

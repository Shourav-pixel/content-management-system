Rails.application.routes.draw do
  resources :tags
  resources :categories
  resources :books
  root 'pages#home'
  # devise_for :users
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations:'users/registrations'
      }

 
  get "up" => "rails/health#show", as: :rails_health_check


end

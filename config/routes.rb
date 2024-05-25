Rails.application.routes.draw do
  resources :storages do
    resources :books
  end
  resources :tags
  resources :categories

  
  resources :books do 
    resource :like, module: :books
    resources :comments
    collection do
      post :search
    end
  end
  root 'pages#home'


  # devise_for :users
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations:'users/registrations'
      }
    
    
 
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :admin do
    resources :users do
      post :bulk_actions, on: :collection
    end
  end


end

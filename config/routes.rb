Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resources :registrations, only: %i[new create ]
  resources :books
  resources :books, param: :slug do
    member do
      post :check_out, to: "circulation_records#check_out"
    end
  end

  resources :circulation_records do
    member do
      patch :check_in
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  #
  get "users/:username", to: "users#profile", as: :users_profile

  # Defines the root path route ("/")
  root "books#index"
end

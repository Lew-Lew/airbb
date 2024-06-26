Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "pages#home"
  resources :flats do
    resources :bookings, only: [:index, :show, :create] do
      member do
        patch :update_status
      end
    end
  end

  get '/my_bookings', to: 'bookings#my_bookings'
  get '/my_flats', to: 'flats#my_flats'
  # Defines the root path route ("/")
  # root "posts#index"
end

Rails.application.routes.draw do
  resources :flights, only: :show
  resources :passengers, only: :show
  post "/passengers/:passenger_id/flights", to: 'passenger_flights#create'
end

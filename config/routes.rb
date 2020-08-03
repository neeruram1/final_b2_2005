Rails.application.routes.draw do
  resources :flights, only: :show
  resources :passengers, only: :show 
end

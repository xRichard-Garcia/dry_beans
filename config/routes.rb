Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :routes, only: [:show] do
        resources :trips, only: [] do
          resources :stops, only: [:create]
        end
      end
    end
  end
end

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'health_check', to: 'health_check#index'
      resources :products, only: [:index, :show]
    end
  end
end

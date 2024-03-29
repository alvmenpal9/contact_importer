Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "/login", to: "auth#login"
      resources :users, only: :create
      resources :contacts
      resources :imports, only: [:create, :index, :show]
    end
  end
end

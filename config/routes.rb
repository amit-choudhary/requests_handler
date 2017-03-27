Rails.application.routes.draw do
  root to: "requests#index"

  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resources :requests, only: [:index, :show, :create] do
    member do
      patch :assign
      patch :solve
    end
    resources :comments, only: :create
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

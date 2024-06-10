Rails.application.routes.draw do
  devise_for :users
  root to: "meal_plans#new"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :meal_plans, only: [:new, :create, :show] do
    resources :grocery_lists, only: [:create, :index]
  end
  resources :meals, only: [:update, :destroy, :show] do
    member do
      patch "replace"
    end
  end
  resources :grocery_items, only: [:update] do
    member do
      patch "mark_as_bought"
    end
  end
  get "map", to: "grocery_lists#mapping", as: :map
  get "meal_plans_empty", to: "meal_plans#empty", as: :meal_plans_empty
end

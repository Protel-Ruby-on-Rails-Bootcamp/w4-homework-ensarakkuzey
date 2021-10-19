Rails.application.routes.draw do
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'
  # get 'profile/index/:user_id', to: 'proile#index', as: 'profile'

  devise_for :users
  resources :profile
  resources :posts do
    resources :comments do
      patch :accept, on: :member
    end
  end

  resources :relationships, only: [:create, :destroy] 

  root 'welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

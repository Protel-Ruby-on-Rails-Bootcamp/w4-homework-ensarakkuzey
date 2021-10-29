Rails.application.routes.draw do
  get 'bookmarks', to: 'bookmarks#index', as: 'bookmarks'
  get 'feed', to: 'feed#index', as: 'feed'
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'
  # get 'profile/index/:user_id', to: 'proile#index', as: 'profile'

  devise_for :users
  resources :profile
  resources :posts do
    resources :comments do
      patch :accept, on: :member
      patch :deny, on: :member
    end
    patch :vote_control, on: :member
    get :create_bookmark, on: :member
    post :delete_bookmark, on: :member
  end

  resources :relationships, only: [:create, :destroy] 
  resources :bookmarks

  root 'welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

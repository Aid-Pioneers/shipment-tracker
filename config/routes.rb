Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :shipments, only: [:index, :show, :new, :create, :edit, :update] do
    resources :pallets, only: [:new, :create, :edit, :update]
    resources :scans, only: [:new, :create]
  end

  resources :projects
end

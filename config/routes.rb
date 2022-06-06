Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'donations', to: 'pages#donations'
  get 'success', to: 'pages#success'
  resources :shipments, only: [:index, :show, :new, :create, :edit, :update] do
    resources :pallets, only: [:new, :create, :edit, :update]
    resources :scans, only: [:new, :create]
    get "qr", to: "shipments#qr"
  end

  resources :projects
end

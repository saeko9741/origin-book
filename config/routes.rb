Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'searches#show'
  get 'homes/about'
  get 'searches/show'
  resources :wordbooks,only: [:index, :create, :edit, :update, :destroy]
end

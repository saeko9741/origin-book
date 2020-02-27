Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homes#top'
  get 'homes/about' => 'homes#about'
  # リソースフルではないルーティング HTTPリクエスト URL, to: 'コントローラ名#アクション名' get homes/about, to 'homes#about'
  resources :wordbooks,except: [:show]
  resources :search_caches,only: [:create]
end
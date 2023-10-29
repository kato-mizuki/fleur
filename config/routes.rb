Rails.application.routes.draw do
  root "public/homes#top"
  
  namespace :admin do
    resources :orders, only: [:show]
    resources :customers, only: [:index,:show,:edit,:update]
    resources :items
    root to: 'homes#top'
  end

  namespace :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'
    get 'orders/thanks' => 'orders#thanks'
    post 'orders/confirm' => 'orders#confirm'
    resources :orders, only: [:new,:index,:create,:show]
    delete '/cart_items' => 'cart_items#destroy_all'
    resources :cart_items, only: [:index,:create,:update,:destroy]
    get 'customers/information' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/update' => 'customers#update'
    get 'customers/withdraw' => 'customers#withdraw'
    patch 'customers/withdraw' => 'customers#withdraw_update'
    resources :items, only: [:index,:show] do
    resource :favorites,only:[:create,:destroy]
    end
  end

  devise_for :admins, skip: [:registrations, :passwords] , controllers: {
    sessions: "admin/sessions"
  }
  
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :customers do
    resources :sessions, only: [:new,:create,:destroy]
    resources :registrations, only: [:new,:create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

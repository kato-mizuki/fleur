Rails.application.routes.draw do
  namespace :admin do
   resources :orders, only: [:show]
  end
  
  namespace :admin do
   resources :customers, only: [:index,:show,:edit,:update]
  end
  
  namespace :admin do
   resources :items
  end
  
  namespace :admin do
   root to: 'homes#top'
  end
  
  namespace :public do
   root to: 'homes#top'
   get '/about' => 'homes#about'
  end
  
  namespace :public do
   get 'orders/thanks' => 'orders#thanks'
   post 'orders/confirm' => 'orders#confirm'
   resources :orders, only: [:new,:index,:create,:show]
  end
  
  namespace :public do
   delete '/cart_items' => 'cart_items#destroy_all'
   resources :cart_items, only: [:index,:create,:update,:destroy]
  end
  
  namespace :public do
   get 'customers/information' => 'customers#show'
   get 'customers/information/edit' => 'customers#edit'
   patch 'customers/update' => 'customers#update'
   get 'customers/withdraw' => 'customers#withdraw'
   patch 'customers/withdraw' => 'customers#withdraw_update'
  end
  
  namespace :public do
   resources :items, only: [:index,:show]
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
  end

  devise_scope :customers do
   resources :registrations, only: [:new,:create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

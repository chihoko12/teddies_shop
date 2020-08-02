Rails.application.routes.draw do
  devise_for :users
  root to: 'teddies#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :teddies, only: [:index, :show]
  resources :orders, only: [:show, :create] do
    resources :payments, only: :new
    resource :qrcode, only: [:show], module: 'orders'
  end

  resource :qrcode, only: [:show]

mount StripeEvent::Engine, at: '/stripe-webhooks'

end

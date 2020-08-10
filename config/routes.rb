Rails.application.routes.draw do
  get 'card/new'
  get 'card/show'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root 'items#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:show, :edit] do
    member do
      get 'logout'
    end
  end

  resources :items do
    member do
    get 'buy'
    get 'pay'
    post 'pay'
    end
  end
  
  resources :card, only: [:new, :create, :show, :destroy] do
  end

end

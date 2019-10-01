Rails.application.routes.draw do
  
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy" 
    get 'my_page', :to => 'users/registrations#my_page'
  end

  root to: 'users#index'
  resources :toppages, only:[:index]
  
  resources :users do
    member do
      get :payments
    end
  end

  resources :payments do
    collection do
      post :confirm
    end
  end
  resources :personnels, only:[:new, :create, :edit, :update, :show]
  resources :events do
    resources :comments
  end
  resources :routines do
    resources :assignments
  end

  resources :card, only: [:new, :show] do
    collection do
      post 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end
  resources :purchase, only: [:index] do
    collection do
      get 'index', to: 'purchase#index'
      post 'pay', to: 'purchase#pay'
      get 'done', to: 'purchase#done'
    end
  end
  resources :card_payments
  resources :conversations do
    resources :messages
  end
  resources :issues, only:[:index, :new, :create, :destroy]
end

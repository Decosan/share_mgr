Rails.application.routes.draw do
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

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
  resources :issues
  
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
end

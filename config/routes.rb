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
  
  resources :users
  resources :personnels, only:[:new, :create, :edit, :update, :show]
end

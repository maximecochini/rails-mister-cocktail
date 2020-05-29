Rails.application.routes.draw do
  resources :cocktails do
    resources :doses, only: [ :index, :new, :create ]
    resources :reviews, only: [ :index, :new, :create ]
  end
  resources :doses, only: [ :show, :edit, :update, :destroy ]
  resources :reviews, only: [ :show, :edit, :update, :destroy ]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

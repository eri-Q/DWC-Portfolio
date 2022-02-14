Rails.application.routes.draw do
  devise_for :users
  root to: 'home#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only:[:index, :show, :edit, :update] do
    member do
      get :follows, :followers
    end
    resource :relationships, only:[:create, :destroy]
  end
  resources :posts do
    resources :comments, only:[:create, :destroy]
    resource :favorites, only:[:create, :destroy]
  end
end

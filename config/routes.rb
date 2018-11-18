Rails.application.routes.draw do
  get 'social_profiles/destroy'
  get 'notifications/link_through'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'follows/create'
  get 'follows/destroy'
  get 'users/index'
  get 'users/show'
  get 'likes/create'
  get 'likes/destroy'
  get 'article_comments/create'
  get 'article_comments/destroy'
  get 'notifications/:id/link_through', to: 'notifications#link_through',
 as: :link_through
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => 'users/registrations'  }
  resources :users, :only => [:index, :show] do
    resources :social_profiles, only: [:destroy]
    resources :article_memos
      member do
          get :following, :followers
      end
  end
  root 'articles#index'
  resources :articles do
      resources :article_comments, only: [:create, :destroy]
      resources :likes, only: [:create, :destroy]
      resources :article_memos
  end
  resources :categories
  resources :article_categories
  resources :follow_relationships, only: [:create, :destroy]
  resources :notifications, only: [:index]
  resources :settings, only: [:show]
  resources :dashboards, only: [:show]
  resources :searches, only: [:index]
end

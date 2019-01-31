Rails.application.routes.draw do
  resources :article_pictures
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
  get 'users', to: 'articles#index'
  get 'article_memos/search', to: 'article_memos#search'

  get 'privacy_policy', to: 'statics#privacy_policy'
  get 'rules', to: 'statics#rules'
  get 'contact', to: 'statics#contact'
  get 'about', to: 'statics#about'

  #設定関係
  get 'settings/dashboards', to: 'dashboards#index', as: :dashboards
  get 'settings/dashboards/preview/:id', to: 'dashboards#show', as: :dashboard_preview
  get 'settings/repositories', to: 'repositories#index'
  get 'settings/integration', to: 'settings#integration'
  get 'settings/delete_account', to: 'settings#delete_account'
  get 'settings/notifications', to: 'notifications#index', as: :notifications

  #通知
  get 'notifications/:id/link_through', to: 'notifications#link_through', as: :link_through

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => 'users/registrations'  }
  resources :users, :only => [:show] do
    resources :social_profiles, only: [:destroy]
    resources :article_memos
    resources :repositories, only: [:create, :update, :destory]
      member do
          get :following, :followers
      end
  end

  devise_scope :user do
    get 'settings/edit_account' => 'users/registrations#edit', as: :edit_account
  end

  root 'articles#index'
  resources :articles do
      resources :article_comments, only: [:create, :destroy]
      resources :likes, only: [:create, :destroy]
      resources :stocks, only: [:create, :destroy]
      resources :article_memos
  end
  resources :follow_relationships, only: [:create, :destroy]
  resources :searches, only: [:index]
  resources :follow_tag_relationships, only: [:create, :destroy]
  resources :stocks, only: [:index]
end

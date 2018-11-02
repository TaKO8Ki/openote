Rails.application.routes.draw do
    get 'follows/create'
    get 'follows/destroy'
    get 'users/index'
    get 'users/show'
    get 'likes/create'
    get 'likes/destroy'
    get 'article_comments/create'
    get 'article_comments/destroy'
    devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
    resources :users, :only => [:index, :show] do
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
end

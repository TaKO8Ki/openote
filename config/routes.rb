Rails.application.routes.draw do
    get 'follows/create'
    get 'follows/destroy'
    get 'users/index'
    get 'users/show'
    get 'likes/create'
    get 'likes/destroy'
    devise_for :users
    resources :users, :only => [:index, :show] do
        member do
            get :following, :followers
        end
    end
    root 'articles#index'
    resources :articles do
        resources :article_comments, only: [:create, :destroy]
        resources :likes, only: [:create, :destroy]
    end
    resources :categories
    resources :article_categories
    resources :follow_relationships, only: [:create, :destroy]
end

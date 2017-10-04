Rails.application.routes.draw do
  get 'sessions/new'

  root             'static_pages#home'
  get 'help'    => 'static_pages#help'
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :microposts, only: [:create, :destroy], shallow: true do
    member do
      put "like", to: "microposts#upvote"
      put "dislike", to: "microposts#downvote"
    end
    resources :comments, only: [:create, :destroy], shallow: true do
      member do
        put "like", to: "comments#upvote"
        put "dislike", to: "comments#downvote"
      end
      resources :subcomments, only: [:create, :destroy] do
        member do
          put "like", to: "subcomments#upvote"
          put "dislike", to: "subcomments#downvote"
        end
      end
    end
  end
  resources :relationships,       only: [:create, :destroy]
end

Carhall::Application.routes.draw do
  # Frontend pages
  # Dashboard
  resource :dashboard, only: :show
  root to: 'dashboards#show'
  # Frontend sign_in/sing_up page
  devise_for :accounts, controllers: { 
    registrations: "accounts/registrations",
    sessions: "accounts/sessions",
    confirmations: "accounts/confirmations",
  }
  devise_scope :account do
    namespace :accounts do
      resource :confirmation
    end
  end

  resource :setting do
    get :template
    get :finance
    
    get :rqrcode
  end

  namespace :users do
    resources :inverse_friends
    resources :reviews do
      get :cleaning, on: :collection
      get :mending, on: :collection
    end
  end

  namespace :tips do
    resource :dashboard, only: :show
    root to: 'dashboards#show'

    resource :mending do
      get :orders
      get :edit_discount
      get :edit_brands
    end

    resources :cleanings do
      get :orders, on: :collection
    end
    
    resources :activities do
      get :in_progress, on: :collection
      get :expired, on: :collection
    end
    
    resources :bulk_purchasings do
      get :in_progress, on: :collection
      get :orders, on: :collection
      get :expired, on: :collection
    end    
  end

  namespace :admins do
    resources :admins
    resources :dealers
    resources :users

    resources :advertisements

    namespace :tips do
      resource :dashboard, only: :show
      root to: 'dashboards#show'
      
      resources :mendings
      resources :cleanings
      resources :activities
      resources :bulk_purchasings
    end
  end

  # For openfire
  resource :openfire, only: [] do
    post :login
    post :login_by_token
    post :get_user
    post :list_users
  end

  # APIs
  namespace :api do
    resources :constants, only: [:index, :show]

    resources :users, only: [:show, :create] do
      get :detail, on: :member

      resources :friends, only: [:index]
      resources :posts, only: [:index]
    end
    
    resources :accounts, only: [:show] do
      get :detail, on: :member
      post :login, on: :collection
      
    end

    resource :current_user, only: [:show, :update] do
      get :detail
      put :password

      resources :friends, only: [:index]
      resources :blacklists, only: [:index]
      resources :post_blacklists, only: [:index]
      resources :posts, only: [:index]
      resource :club, only: [:show]
    end

    resources :dealers, only: [:index, :show] do
      get :nearby, on: :collection
      get :favorite, on: :collection
      get :hot, on: :collection

      get :detail, on: :member
      
      namespace :tips, path: '' do
        resource :mending, only: [:show] do
          get :detail
        end

        resources :cleanings, only: [:index] do
          get :nearby, on: :collection
          get :cheapie, on: :collection
          get :favorite, on: :collection
          get :hot, on: :collection
        end
        
        resources :activities, only: [:index] do
          get :nearby, on: :collection
        end
        
        resources :bulk_purchasings, only: [:index] do
          get :nearby, on: :collection
          get :cheapie, on: :collection
          get :favorite, on: :collection
          get :hot, on: :collection
        end

        resources :orders, only: [:index, :show]
        resources :reviews, only: [:index, :show]
        
      end
    end

    resources :providers, only: [:index, :show] do
      get :detail, on: :member
    end

    resources :friends, only: [:index, :destroy] do
      post ':id', action: :create, on: :collection
    end

    resources :blacklists, only: [:index, :destroy] do
      post ':id', action: :create, on: :collection
    end

    resources :post_blacklists, only: [:index, :destroy] do
      post ':id', action: :create, on: :collection
    end

    resource :club, only: [:show, :update] do
      post :president
      post :mechanics
    end

    resources :posts, only: [:index, :show, :create, :destroy] do
      get :friends, on: :collection
      get :top, on: :collection
      get :club, on: :collection

      resources :comments, only: [:index, :show, :create, :destroy]
    end

    namespace :tips do
      resources :mendings, only: [:index, :show] do
        get :nearby, on: :collection
        get :favorite, on: :collection
        get :hot, on: :collection
  
        get :detail, on: :member

        resources :orders, only: [:index, :show, :create] do
          put :finish, on: :member
          post :review, on: :member
          delete :cancel, on: :member
        end

        resources :reviews, only: [:index, :show]
      end

      resources :cleanings, only: [:index, :show] do
        get :nearby, on: :collection
        get :cheapie, on: :collection
        get :favorite, on: :collection
        get :hot, on: :collection
  
        get :detail, on: :member

        resources :orders, only: [:index, :show, :create] do
          put "use/:count", action: :use, on: :member
          put :use, on: :member
          post :review, on: :member
          delete :cancel, on: :member
        end

        resources :reviews, only: [:index, :show]
      end
      
      resources :activities, only: [:index, :show] do
        get :nearby, on: :collection
  
        get :detail, on: :member        
        
      end
      
      resources :bulk_purchasings, only: [:index, :show] do
        get :nearby, on: :collection
        get :cheapie, on: :collection
        get :favorite, on: :collection
        get :hot, on: :collection
  
        get :detail, on: :member

        resources :orders, only: [:index, :show, :create] do
          put :finish, on: :member
          post :review, on: :member
          delete :cancel, on: :member
        end
        
        resources :reviews, only: [:index, :show]
      end

    end

    # Need to return JSON-formatted 404 error in Rails
    match '*foo', to: ->(env) { [404, {"Content-Type" => "application/json; charset=utf-8"}, [{
      error: "No route matches [#{env["REQUEST_METHOD"]}] \"#{env["PATH_INFO"]}\"",
      error_code: :not_found,
      success: false
    }.to_json]] }, via: :all
  end

end

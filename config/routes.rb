Carhall::Application.routes.draw do
  # Frontend pages
  # Dashboard
  resource :dashboard, only: :show
  root to: 'dashboards#show'
  # Frontend sign_in/sing_up page
  devise_for :accounts, :class_name => "Accounts::Account", controllers: { 
    registrations: "accounts/registrations",
    sessions: "accounts/sessions",
    confirmations: "accounts/confirmations",
    passwords: "accounts/passwords",
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

  namespace :bcst do
    resource :dashboard, only: :show
    root to: 'dashboards#show'
    

    resources :hosts
    resources :programme_lists
    resources :programmes do
      resources :comments
    end

    resources :exposures
    resources :traffic_reports
  end

  namespace :statistic do
    resources :providers
    resources :dealers
    resources :users
  end

  namespace :accounts do
    resources :admins
    resources :providers
    resources :dealers
    resources :users
  end

  namespace :business do
    resource :advert
    resource :push
    resources :ad_templates
    resources :tutorials
  end

  namespace :category do
    resources :brands
  end

  # For openfire
  resource :openfire, only: [] do
    post :login
    post :login_by_token
    post :get_user
    post :list_users
  end


  ############################
  # APIs
  namespace :api do
    resources :constants, only: [:index, :show]

    # Accounts
     scope module: :accounts do
      resources :users, only: [:show, :create] do
        get :detail, on: :member

        resources :friends, only: [:index] do
          get :user, on: :collection
          get :dealer, on: :collection
          get :provider, on: :collection
        end
      end
      
      resources :accounts, only: [:show] do
        get :detail, on: :member
        post :login, on: :collection
        
      end

      resource :current_user, only: [:show, :update] do
        get :detail
        put :password

        resources :friends, only: [:index] do
          get :user, on: :collection
          get :dealer, on: :collection
          get :provider, on: :collection
        end
        resources :blacklists, only: [:index]
      end

      resources :dealers, only: [:index, :show] do
        get :nearby, on: :collection
        get :favorite, on: :collection
        get :hot, on: :collection

        get :detail, on: :member
      end

      resources :providers, only: [:index, :show] do
        get :detail, on: :member
      end

      resources :friends, only: [:index, :destroy] do
        get :user, on: :collection
        get :dealer, on: :collection
        get :provider, on: :collection

        post ':id', action: :create, on: :collection
      end

      resources :blacklists, only: [:index, :destroy] do
        post ':id', action: :create, on: :collection
      end
    end

    # Share::Comment
    resources :comments, only: [:index, :show, :create, :destroy]

    # Posts
    scope module: :posts do
      resources :posts, only: [:index, :show, :create, :destroy] do
        get :friends, on: :collection
        get :top, on: :collection
        get :club, on: :collection
        
        resources :comments, only: [:index, :show, :create, :destroy]
      end

      resources :post_blacklists, only: [:index, :destroy] do
        post ':id', action: :create, on: :collection
      end

      resource :club, only: [:show, :update] do
        post :president
        post :mechanics
      end

      resource :current_user, only: [] do
        resources :post_blacklists, only: [:index]
        resources :posts, only: [:index]
        resource :club, only: [:show]
      end

      resources :users, only: [] do
        resources :posts, only: [:index]
      end
    end

    # Tips
    scope module: :tips do
      resources :dealers, only: [] do
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

    # Bcst
    scope module: :bcst do
      resources :providers, only: [] do
        resources :hosts, only: [:index]
        resources :programmes, only: [:index]
        resource :programme_list, only: [:show]

        resources :exposures, only: [:index, :show, :create, :destroy]
        resources :traffic_reports, only: [:index, :show, :create, :destroy]
      end
    end

    namespace :bcst do
      resources :hosts, only: [:index, :show] do
        get :detail, on: :member
      end
      resources :programmes, only: [:index, :show] do
        get :detail, on: :member
        
        resources :comments, only: [:index, :show, :create, :destroy]
      end

      resource :programme_list, only: [:show] do
        get :detail
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

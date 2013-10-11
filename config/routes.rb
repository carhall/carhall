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
  end

  namespace :statistic do
    resource :dashboard
    root to: 'dashboards#show'

    resources :distributors
    resources :dealers
    resources :providers
    resources :users

    resources :inverse_friends
    resources :reviews do
      get :mending, on: :collection
      get :cleaning, on: :collection
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

    resources :mendings do
      put :expose, on: :member
      put :hide, on: :member
      put :stick, on: :member
      put :unstick, on: :member

      resources :orders
    end

    resources :cleanings do
      put :expose, on: :member
      put :hide, on: :member
      put :stick, on: :member
      put :unstick, on: :member

      resources :orders
    end
    
    resources :activities do
      put :expose, on: :member
      put :hide, on: :member
      put :stick, on: :member
      put :unstick, on: :member

      get :in_progress, on: :collection
      get :expired, on: :collection
    end
    
    resources :bulk_purchasings do
      put :expose, on: :member
      put :hide, on: :member
      put :stick, on: :member
      put :unstick, on: :member
      
      get :in_progress, on: :collection
      get :expired, on: :collection

      resources :orders
    end

    resources :orders do
      get :mending, on: :collection
      get :cleaning, on: :collection
      get :bulk_purchasing, on: :collection
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

  namespace :accounts do
    resources :admins

    resources :agents do
      put :accept, on: :member
    end
    resources :distributors do
      put :accept, on: :member
    end
    resources :dealers do
      put :accept, on: :member
      put :expose, on: :member
      put :hide, on: :member
      put :stick, on: :member
      put :unstick, on: :member
    end
    resources :providers do
      put :accept, on: :member
      put :expose, on: :member
      put :hide, on: :member
      put :stick, on: :member
      put :unstick, on: :member
    end

    resources :users
    resources :candidates do
      get :president, on: :collection
      get :president, on: :member
      get :mechanic, on: :collection
      get :mechanic, on: :member
    end

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

  namespace :posts do
    resources :posts
    resources :clubs do
      delete :relieve_president, on: :member
      delete 'relieve_mechanic/:mechanic_id', action: :relieve_mechanic, on: :member
    end
    resources :president_candidates do
      put :appoint, on: :member
    end
    resources :mechanic_candidates do
      put :appoint, on: :member
    end
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
      resources :accounts, only: [:index, :show] do
        get :detail, on: :member
        post :login, on: :collection
        
      end
      
      resources :users, only: [:index, :show, :create] do
        get :detail, on: :member

        resources :friends, only: [:index] do
          get :user, on: :collection
          get :dealer, on: :collection
          get :provider, on: :collection
        end
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

      resource :current_user, only: [] do
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

Carhall::Application.routes.draw do
  # Frontend pages
  # Dashboard
  resource :dashboard, only: :show do
    get :cooperations
    get :about_us
    get :help

    post :send_invitation
  end
  root to: 'dashboards#show'
  
  # Frontend sign_in/sing_up page
  devise_for :accounts, class_name: "Accounts::Account", module: "accounts"
  devise_scope :account do
    namespace :accounts do
      resource :confirmation
    end
  end

  resource :setting do
    get :template
    get :finance
    get :weixin
    get "weixin/:step", action: :weixin
  end

  namespace :statistic do
    resource :dashboard
    root to: 'dashboards#show'

    resources :distributors
    resources :dealers
    resources :providers
    resources :users

    resources :friends
    resources :user_friends
    resources :dealer_friends
    resources :distributor_friends
    resources :reviews do
      get :mending, on: :collection
      get :cleaning, on: :collection
    end

    resources :sales_cases
  end

  namespace :tips do
    resource :dashboard, only: :show
    root to: 'dashboards#show'

    resources :mendings do
      put :expose, on: :member
      put :hide, on: :member
      put :stick, on: :member
      put :unstick, on: :member

      resources :orders
    end

    resource :mending do
      get :orders
      get :edit_discount
      get :edit_brands
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

    resources :vip_cards do
      put :disable, on: :member
      put :reenable, on: :member

      resources :orders
    end

    resources :orders do
      get :mending, on: :collection
      get :cleaning, on: :collection
      get :bulk_purchasing, on: :collection
      get :bulk_purchasing2, on: :collection
      get :vip_card, on: :collection

      put :enable, on: :member
    end

    resources :purchase_requestings do
      get :in_progress, on: :collection
      get :expired, on: :collection

    end

    resources :bulk_purchasing2s do
      get :in_progress, on: :collection
      get :expired, on: :collection

      resources :orders
    end

    resources :manual_images

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
      put :rank_down, on: :member
    end
    resources :distributors do
      put :accept, on: :member
      put :rank_up, on: :member
      put :rank_down, on: :member
    end
    resources :dealers do
      put :accept, on: :member
      put :expose, on: :member
      put :hide, on: :member
      put :stick, on: :member
      put :unstick, on: :member
      put :rank_up, on: :member
      put :rank_down, on: :member
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
    resources :adverts do
      get :client, on: :collection
      get :ad_template, on: :collection
      get :tutorial, on: :collection
    end
    resource :push
    resources :ad_templates
    resources :tutorials
    resources :client_versions
  end

  namespace :category do
    resources :brands
    resources :products
  end

  namespace :posts do
    resources :posts do
      resources :comments, shallow: true
    end
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

  namespace :dashboard do
    resources :bulk_purchasing2s do
      resources :bulk_purchasing2_orders
    end
    resources :purchase_requestings
    resources :distributors do
      get :manual_images, on: :member
      post :make_friend, on: :member
      delete :break, on: :member
    end
    resources :ad_templates do
      post :buy, on: :member
    end
    resources :tutorials  
  end


  namespace :weixin do
    devise_for :accounts, class_name: "Accounts::Account", module: "weixin/accounts"
    devise_scope :account do
      namespace :accounts do
        resource :confirmation
        get :check, to: "weixin/accounts/registrations#check" 
      end
    end
    
    scope module: :accounts do
      resources :dealers
      resource :current_user do
        get :mine
      end
    end

    scope module: :statistic do
      resource :current_user do
        resources :consumption_records, only: [:show, :index]
        resources :sales_cases, only: [:show, :index]
      end
    end

    scope module: :tips do
      resources :dealers do
        resource :mending, only: [:show] do
          resources :orders, only: [:index, :new, :create] do
            post :thank_you, on: :collection
          end
          resources :reviews, only: [:index]
        end
        resources :cleanings, only: [:show, :index] do
          resources :orders, only: [:index, :new, :create] do
            post :thank_you, on: :collection
          end
          resources :reviews, only: [:index]
        end
        resources :activities, only: [:show, :index]
        resources :bulk_purchasings, only: [:show, :index] do
          resources :orders, only: [:index, :new, :create] do
            post :thank_you, on: :collection
          end
          resources :reviews, only: [:index]
        end
        resources :vip_cards, only: [:show, :index] do
          resources :orders, only: [:index, :new, :create] do
            post :thank_you, on: :collection
          end
          resources :reviews, only: [:index]
        end
      end

      resource :current_user do
        resources :vip_card_orders, only: [:show, :index]
      end
    end

    root to: "accounts/current_users#show"
  end

  mount WeixinAPI => '/weixin'
  mount OpenfireAPI => '/openfire'
  mount AssistantAPI => '/assistant'

  # resource :openfire, only: [] do
  #   post :login
  #   post :login_by_token
  #   post :get_user
  #   post :list_users
  #   post :send_file
  # end

  ############################
  # APIs
  namespace :api do
    resources :adverts, only: [:index]

    resources :constants, only: [:index, :show] do
      get :brands, on: :collection
      post :version, on: :collection
    end

    # Accounts
     scope module: :accounts do
      resources :accounts, only: [:index, :show] do
        get :detail, on: :member
        post :login, on: :collection
        post :confirm, on: :collection
        post :resend_confirm, on: :collection
        
        post :password, on: :collection
        post :send_password, on: :collection
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

        resources :vip_cards, only: [:index]

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
  
        get :followed, on: :collection
  
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
  
        get :followed, on: :collection
        
        get :detail, on: :member

        resources :orders, only: [:index, :show, :create] do
          put :finish, on: :member
          post :review, on: :member
          delete :cancel, on: :member
        end

        resources :reviews, only: [:index, :show]
      end
        
      resources :vip_cards, only: [:index, :show] do
        get :detail, on: :member

        resources :orders, only: [:index, :show, :create] do
          put :finish, on: :member
          post :review, on: :member
          delete :cancel, on: :member
        end

        resources :reviews, only: [:index, :show]
      end

      resources :orders, only: [:index, :show] do
        put :finish, on: :member
        put "use/:count", action: :use, on: :member
        put :use, on: :member
        post :review, on: :member
        delete :cancel, on: :member
      end
      
      resources :mending_orders, only: [:index, :show] do
        put :finish, on: :member
        post :review, on: :member
        delete :cancel, on: :member
      end
      
      resources :cleaning_orders, only: [:index, :show] do
        put :finish, on: :member
        put "use/:count", action: :use, on: :member
        put :use, on: :member
        post :review, on: :member
        delete :cancel, on: :member
      end
      
      resources :bulk_purchasing_orders, only: [:index, :show] do
        put :finish, on: :member
        post :review, on: :member
        delete :cancel, on: :member
      end

      resources :vip_card_orders, only: [:index, :show] do
        put :finish, on: :member
        put "use/:count", action: :use, on: :member
        put :use, on: :member
        post :review, on: :member
        delete :cancel, on: :member
      end
      
      resources :reviews, only: [:index, :show]

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

  get 'Carhall', format: :apk, to: "dashboards#download_apk"

  post '*foo', format: :do, to: ->(env) { [404, {}, []] }
end

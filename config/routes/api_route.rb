Carhall::Application.routes.draw do
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

end
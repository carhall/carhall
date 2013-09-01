Autozone::Application.routes.draw do
  # Frontend pages
  # Dashboard
  resource :dashboard, only: :show
  root to: 'dashboards#show'

  # Frontend sign_in/sing_up page
  devise_for :base_users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
  }

  resources :inverse_friends
  resources :settings

  devise_scope :base_users do
    # APIs
    namespace :api do
      resources :users, only: [:index, :show, :create] do
        get :detail, on: :member
        post :login, on: :collection

        resources :friends, only: [:index]
        resources :posts, only: [:index]
      end

      resource :current_user, only: [:show, :update] do
        get :detail
        put :password
        put :detail, action: :update_detail

        resources :friends, only: [:index]
        resources :posts, only: [:index]
      end

      resources :dealers, only: [:index, :show] do
        get :detail

        resources :orders, only: [:index, :show]
        resources :reviews, only: [:index, :show]
      end

      resources :providers, only: [:index, :show] do
        get :detail
      end

      resources :friends, only: [:index, :destroy] do
        post ':id', action: :create, on: :collection
      end

      resources :posts, only: [:show, :create, :destroy] do
        get :index, action: :friends, on: :collection
        get :friends, on: :collection
        get :top, on: :collection
        get :club, on: :collection

        resources :comments, only: [:index, :show, :create, :destroy]

      end

      namespace :tips do
        resources :mendings, only: [:index, :show] do
          resources :orders, only: [:index, :show, :create] do
            put :finish, on: :member
            post :review, on: :member
            delete :cancel, on: :member
          end

          resources :reviews, only: [:index, :show]
        end

        resources :cleanings, only: [:index, :show] do
          resources :orders, only: [:index, :show, :create] do
            put "use/:count", action: :use, on: :member
            post :review, on: :member
            delete :cancel, on: :member
          end

          resources :reviews, only: [:index, :show]
        end
        
        resources :activities, only: [:index, :show]
        
        resources :bulk_purchasings, only: [:index, :show] do
          resources :orders, only: [:index, :show, :create] do
            put :finish, on: :member
            post :review, on: :member
            delete :cancel, on: :member
          end
          
          resources :reviews, only: [:index, :show]
        end

      end

      # Need to return JSON-formatted 404 error in Rails
      match '*foo', :to => ->(env) { [404, {"Content-Type" => "application/json; charset=utf-8"}, [{
        error: "No route matches [#{env["REQUEST_METHOD"]}] \"#{env["PATH_INFO"]}\"",
        success: false
      }.to_json]] }
    end
  end

end

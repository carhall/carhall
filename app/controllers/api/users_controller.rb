class Api::UsersController < Api::BaseController
  skip_before_filter :authenticate_base_user!, only: [:login, :create]

  # GET /api/users/1
  # GET /api/users/1.json
  def show
    render_show BaseUser.find(params[:id])
  end
  
  # GET /api/users/1/detail
  # GET /api/users/1/detail.json
  def detail
    render_show BaseUser.find(params[:id]).detail_hash
  end

  # POST /api/users/login
  # POST /api/users/login.json
  def login
    @user = BaseUser.find_for_database_authentication(mobile: params[:data][:mobile])

    if @user && @user.valid_password?(params[:data][:password])
      @user.reset_authentication_token!  # make sure the user has a token generated      
      render_create_success @user, { auth_token: @user.authentication_token }
    else
      warden.custom_failure!
      render_error t('devise.failure.invalid'), :unauthorized
    end
  end

  # POST /api/users
  # POST /api/users.json
  def create
    @user = User.new params[:data]
    @user.reset_authentication_token

    render_create @user, { auth_token: @user.authentication_token }
  end
end

class Api::UsersController < Api::ApplicationController
  skip_before_filter :authenticate_user!, only: [:login, :create]

  set_resource_class User, detail: true

  # POST /api/users/login
  # POST /api/users/login.json
  def login
    @user = User.find_for_database_authentication(mobile: params[:data][:mobile])

    if @user && @user.valid_password?(params[:data][:password])
      @user.reset_authentication_token!  # make sure the user has a token generated
      sign_in(@user)  
      render_create_success @user, { auth_token: @user.authentication_token }
    else
      warden.custom_failure!
      render_error t('devise.failure.invalid'), :unauthorized
    end
  end

  # GET /api/users/logout
  # GET /api/users/logout.json
  # DELETE /api/users/logout
  # DELETE /api/users/logout.json
  def logout
    sign_out(resource_name)
  end

  # POST /api/users
  # POST /api/users.json
  def create
    @user = Consumer.new params[:data]
    @user.reset_authentication_token

    render_create @user, { auth_token: @user.authentication_token }
  end
end

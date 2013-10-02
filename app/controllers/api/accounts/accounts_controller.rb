class Api::Accounts::AccountsController < Api::Accounts::ApplicationController
  skip_before_filter :authenticate_account!, only: [:login]

  set_resource_class ::Accounts::Account, detail: true

  # POST /api/accounts/login
  # POST /api/accounts/login.json
  def login
    @user = Accounts::Account.find_for_database_authentication(mobile: params[:data][:mobile])

    if @user && @user.valid_password?(params[:data][:password])
      @user.reset_authentication_token!  # make sure the user has a token generated
      sign_in(@user)
      render_create_success @user, :with_token
    else
      warden.custom_failure!
      render_error t('devise.failure.invalid'), :unauthorized
    end
  end

  # GET /api/accounts/logout
  # GET /api/accounts/logout.json
  # DELETE /api/accounts/logout
  # DELETE /api/accounts/logout.json
  def logout
    sign_out(current_account)
  end

end

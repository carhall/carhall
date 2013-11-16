class Api::Accounts::AccountsController < Api::Accounts::ApplicationController
  skip_before_filter :authenticate_account_from_token!, only: [:login, :confirm, :resend_confirm]

  set_resource_class ::Accounts::Account, detail: true
  before_filter :search_parent

  def set_parent
    if params[:filter]
      if params[:filter][:user_type]
        user_type = {
          'public_account' => Accounts::PublicAccount,
          'admin' => Accounts::Admin,
          'dealer' => Accounts::Dealer,
          'provider' => Accounts::Provider,
          'user' => Accounts::User,
        }
        klass = user_type[params[:filter][:user_type]]
        @parent = klass.all
        @parent = @parent.where(display: true) if klass <= Accounts::PublicAccount

      end
    end
    @parent ||= ::Accounts::Account.all
  end

  # POST /api/accounts/login
  # POST /api/accounts/login.json
  def login
    @user = ::Accounts::Account.find_for_database_authentication(mobile: params[:data][:mobile])

    if @user && @user.valid_password?(params[:data][:password])
      sign_in(@user)
      @user.reset_authentication_token!  # make sure the user has a token generated
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

  def confirm
    @user = ::Accounts::Account.confirm_by_token(params[:data][:confirmation_token])

    if @user.errors.empty?
      render_update_success @user
    else
      render_failure @user
    end
  end

  def resend_confirm
    @user = ::Accounts::Account.send_confirmation_instructions(mobile: params[:data][:mobile])
    
    if @user.errors.empty?
      render_update_success @user
    else
      render_failure @user
    end
  end

  def password
    @user = ::Accounts::Account.reset_password_by_token(params[:data].permit(:reset_password_token, :password))

    if @user.errors.empty?
      render_update_success @user
    else
      render_failure @user
    end
  end

  def send_password
    @user = ::Accounts::Account.send_reset_password_instructions(mobile: params[:data][:mobile])
    
    if @user.errors.empty?
      render_update_success @user
    else
      render_failure @user
    end
  end

end

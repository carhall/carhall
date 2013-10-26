class OpenfiresController < ActionController::Base
  include Api::RenderHelper

  def login
    @user = ::Accounts::Account.find_for_database_authentication(mobile: params[:mobile])

    if @user && @user.valid_password?(params[:password])
      @user.ensure_authentication_token!
      render_data @user.as_api_response(:openfire_user_info)
    else
      warden.custom_failure!
      render_error t('devise.failure.invalid'), :unauthorized
    end
  end

  def login_by_token
    @user = ::Accounts::Account.where(authentication_token: params[:token]).first

    if @user
      @user.ensure_authentication_token!
      render_data @user.as_api_response(:openfire_user_info)
    else
      warden.custom_failure!
      render_error t('devise.failure.invalid'), :unauthorized
    end
  end

  def get_user
    @user = ::Accounts::Account.find(params[:id])
    render_data user: @user.as_api_response(:openfire_user_detail)
  end

  def list_users
    @users = ::Accounts::Account.find(params[:ids].split(','))
    render_data users: @users.as_api_response(:openfire_user_detail)
  end

end

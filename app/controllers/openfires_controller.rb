class OpenfiresController < ActionController::Base
  include Api::RenderHelper

  def login
    @user = ::Accounts::Account.find_for_database_authentication(mobile: params[:mobile])

    if @user && @user.valid_password?(params[:password])
      @user.ensure_authentication_token!
      render_data @user.to_openfire_user_info_builder
    else
      warden.custom_failure!
      render_error t('devise.failure.invalid'), :unauthorized
    end
  end

  def login_by_token
    @user = ::Accounts::Account.where(authentication_token: params[:token]).first

    if @user
      @user.ensure_authentication_token!
      render_data @user.to_openfire_user_info_builder
    else
      warden.custom_failure!
      render_error t('devise.failure.invalid'), :unauthorized
    end
  end

  def get_user
    @user = ::Accounts::Account.find(params[:id])
    render_data @user.to_openfire_user_detail_builder.attributes!
  end

  def list_users
    @users = ::Accounts::Account.find(params[:ids].split(','))
    render_data @users.map{|u|u.to_openfire_user_detail_builder.attributes!}
  end

  def send_file
    @upload = ::Share::Upload.new(file: params[:imres], type_id: params[:type])

    if @upload.save
      render_data filePath: "#{AbsoluteUrlPrefix}#{@upload.file.url}"
    else
      render_failure @upload
    end
  end

end
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

Accounts::Account.class_eval do
  def user_type_id
    {
      guest: 1,
      admin: 2,
      user: 3,
      dealer: 4,
      provider: 5,
      distributor: 6,
      agent: 7,
    }[user_type]
  end

  def avatar_thumb_url
    "#{AbsoluteUrlPrefix}#{avatar.url(:thumb, timestamp: false)}" if avatar.present?
  end

  def to_openfire_user_info_builder
    Jbuilder.new do |json|
      json.extract! self, :id, :mobile, :user_type_id
      json.token authentication_token
    end
  end

  def to_openfire_user_detail_builder
    Jbuilder.new do |json|
      json.extract! self, :id, :username, :mobile, :user_type_id, :avatar_thumb_url
      json.sex_id(sex_id||0)
    end
  end
end

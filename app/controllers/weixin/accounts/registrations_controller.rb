class Weixin::Accounts::RegistrationsController < Devise::RegistrationsController
  layout "weixin"

protected

  def resource_name
    :weixin_account
  end
  
  def resource_class
    Accounts::User
  end

  def sign_up_params
    params.require(resource_name).permit(
      :username, :mobile, :password, :password_confirmation, 
      :area_id, :brand_id, :sex_id, :plate_num, :description
      )
  end

  def account_update_params
    params.require(resource_name).permit(
      :username, :area_id, :brand_id, :sex_id, :plate_num, :description
      )
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_sign_up_path_for(resource)
    { action: :show, controller: :'weixin/accounts/current_users' }
  end

  def after_update_path_for(resource)
    { action: :show, controller: :'weixin/accounts/current_users' }
  end

  def after_inactive_sign_up_path_for resource
    if resource.confirmed?
      { action: :show, controller: :'weixin/accounts/current_users' }
    else
      { action: :edit, controller: :'weixin/accounts/confirmations' }
    end
  end

end 
class Weixin::Accounts::SessionsController < ::Accounts::SessionsController
  layout "weixin"

protected

  def resource_name
    :weixin_account
  end
  
  def after_sign_in_path_for(resource)
    { action: :show, controller: :'weixin/accounts/current_users' }
  end

  def after_sign_out_path_for(resource)
    { action: :show, controller: :'weixin/accounts/current_users' }
  end

end 
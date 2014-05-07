class Weixin::Accounts::SessionsController < ::Accounts::SessionsController
  layout "weixin"

protected

  def resource_name
    :weixin_account
  end
  
  def after_sign_in_path_for(resource)
    session["weixin_account_return_to"] || weixin_root_path
  end

  def after_sign_out_path_for(resource)
    weixin_root_path
  end

end 
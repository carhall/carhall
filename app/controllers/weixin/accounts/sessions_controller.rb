class Weixin::Accounts::SessionsController < ::Accounts::SessionsController
  layout "weixin"
  before_filter :logout_others, only: :new

protected

  def logout_others
    sign_out :account
    sign_out :weixin_dealer
  end

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
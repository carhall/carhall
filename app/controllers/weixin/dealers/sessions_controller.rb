class Weixin::Dealers::SessionsController < ::Accounts::SessionsController
  layout "weixin"

protected

  def resource_name
    :weixin_dealer
  end
  
  def after_sign_in_path_for(resource)
    session["weixin_dealer_return_to"] || weixin_current_dealer_path
  end

  def after_sign_out_path_for(resource)
    weixin_current_dealer_path
  end

end
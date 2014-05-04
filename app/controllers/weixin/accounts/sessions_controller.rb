class Weixin::Accounts::SessionsController < ::Accounts::SessionsController
  layout "weixin"

  def after_sign_in_path_for resource
    { action: :show, controller: :'weixin/accounts/current_users' }
  end

end 
class Weixin::Accounts::SessionsController < ::Accounts::SessionsController
  layout "weixin"

  def root_path
    { action: :show, controller: :'weixin/accounts/current_users' }
  end

end 
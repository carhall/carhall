class Weixin::Accounts::RegistrationsController < Devise::RegistrationsController
  layout "weixin"

protected

  def after_inactive_sign_up_path_for resource
    if resource.confirmed?
      { action: :show, controller: :'weixin/accounts/current_users' }
    else
      { action: :edit, controller: :'weixin/accounts/confirmations' }
    end
  end

end 
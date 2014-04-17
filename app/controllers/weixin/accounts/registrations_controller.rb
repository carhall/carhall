class Weixin::Accounts::RegistrationsController < Devise::RegistrationsController
  layout "weixin"

protected

  def root_path
    { action: :show, controller: :'weixin/accounts/current_users' }
  end

  def after_inactive_sign_up_path_for resource
    if resource.confirmed?
      root_path
    else
      { action: :edit, controller: :'weixin/accounts/confirmations' }
    end
  end

end 
class Weixin::Accounts::PasswordsController < ::Accounts::PasswordsController
  layout "weixin"

protected

  def after_resetting_password_path_for resource
    { action: :show, controller: :'weixin/accounts/current_users' }
  end
  
  # The path used after sending reset password instructions
  def after_sending_reset_password_instructions_path_for(resource_name)
    edit_password_path(resource_name) if is_navigational_format?
  end

end 
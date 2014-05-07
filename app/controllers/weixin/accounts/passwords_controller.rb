class Weixin::Accounts::PasswordsController < ::Accounts::PasswordsController
  layout "weixin"

protected

  def resource_name
    :weixin_account
  end
  
  def after_resetting_password_path_for resource
    weixin_root_path
  end
  
  # The path used after sending reset password instructions
  def after_sending_reset_password_instructions_path_for(resource_name)
    edit_password_path(resource_name) if is_navigational_format?
  end

end 
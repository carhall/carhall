class Accounts::PasswordsController < Devise::PasswordsController
  skip_before_filter :assert_reset_token_passed

  # GET /resource/password/edit
  def edit
    self.resource = resource_class.new
  end

protected

  # The path used after sending reset password instructions
  def after_sending_reset_password_instructions_path_for(resource_name)
    edit_password_path(resource_name) if is_navigational_format?
  end

end 
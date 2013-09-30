class Accounts::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/edit
  def edit
    self.resource = resource_class.new
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def update
    self.resource = resource_class.confirm_by_token(params[resource_name][:confirmation_token])

    if resource.errors.empty?
      set_flash_message(:notice, :confirmed) if is_navigational_format?
      sign_in(resource_name, resource)
      respond_with_navigational(resource){ redirect_to after_confirmation_path_for(resource_name, resource) }
    else
      respond_with(resource)
    end
  end

protected

  # The path used after resending confirmation instructions.
  def after_resending_confirmation_instructions_path_for(resource_name)
    edit_accounts_confirmation_path if is_navigational_format?
  end

end 
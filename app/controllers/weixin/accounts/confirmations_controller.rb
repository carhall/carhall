class Weixin::Accounts::ConfirmationsController < ::Accounts::ConfirmationsController
  layout "weixin"

protected

  def resource_name
    :weixin_account
  end
  
  # The path used after resending confirmation instructions.
  def after_resending_confirmation_instructions_path_for(resource_name)
    edit_weixin_accounts_confirmation_path if is_navigational_format?
  end

end 
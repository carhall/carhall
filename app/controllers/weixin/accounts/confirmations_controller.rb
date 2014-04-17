class Weixin::Accounts::ConfirmationsController < ::Accounts::ConfirmationsController
  layout "weixin"

protected

  def root_path
    { action: :show, controller: :'weixin/accounts/current_users' }
  end
  
  # The path used after resending confirmation instructions.
  def after_resending_confirmation_instructions_path_for(resource_name)
    edit_weixin_accounts_confirmation_path if is_navigational_format?
  end

end 
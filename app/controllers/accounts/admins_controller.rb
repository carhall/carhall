class Accounts::AdminsController < Accounts::ApplicationController
  set_resource_class Accounts::Admin

  def accounts_admin_params
    params.require(:accounts_admin).permit!
  end

end
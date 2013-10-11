class Accounts::DistributorsController < Accounts::ApplicationController
  # set_resource_class Accounts::Admin, accept: true

  def accounts_distributor_params
    params.require(:accounts_distributor).permit!
  end

end
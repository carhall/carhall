class Accounts::AgentsController < Accounts::ApplicationController
  # set_resource_class Accounts::Admin, accept: true

  def accounts_agent_params
    params.require(:accounts_agent).permit!
  end

end
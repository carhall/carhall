class Accounts::AgentsController < Accounts::ApplicationController
  set_resource_class Accounts::Agent, accept: true, rank: true

end
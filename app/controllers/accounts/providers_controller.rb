class Accounts::ProvidersController < Accounts::ApplicationController
  set_resource_class Accounts::Provider, accept: true

end
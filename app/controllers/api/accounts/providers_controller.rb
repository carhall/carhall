class Api::Accounts::ProvidersController < Api::Accounts::ApplicationController
  set_resource_class ::Accounts::Provider, detail: true

end

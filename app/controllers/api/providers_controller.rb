class Api::ProvidersController < Api::ApplicationController
  set_resource_class Provider, detail: true

end

class Api::ProvidersController < Api::BaseController
  set_resource_class Provider, detail: true

end

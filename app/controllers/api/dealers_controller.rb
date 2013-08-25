class Api::DealersController < Api::BaseController
  set_resource_class Dealer, detail: true

end

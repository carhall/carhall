class Api::DealersController < Api::ApplicationController
  set_resource_class Dealer, detail: true

end

class Accounts::DealersController < Accounts::ApplicationController
  set_resource_class Accounts::Dealer, accept: true, display: true, rank: true, weixin: true

end
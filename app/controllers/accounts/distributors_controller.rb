class Accounts::DistributorsController < Accounts::ApplicationController
  set_resource_class Accounts::Distributor, accept: true, rank: true, weixin: true

end
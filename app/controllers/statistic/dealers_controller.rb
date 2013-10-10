class Statistic::DealersController < Statistic::ApplicationController
  load_and_authorize_resource class: ::Accounts::Dealer

end
class Users::ReviewsController < ApplicationController
  authorize_resource class: Tips::Review
  before_filter :set_dealer

  helper StatisticsHelper

  def cleanings
    @cleanings = @dealer.cleanings
  end
  
  def mending
    @mending = @dealer.mending || Tips::Mending.create(dealer: @dealer)
    @types = Tips::MendingOrderDetail::MendingType.all
  end
end
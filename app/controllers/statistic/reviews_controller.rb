class Statistic::ReviewsController < Statistic::ApplicationController
  authorize_resource class: Tips::Review
  before_filter :set_dealer

  helper StatisticsHelper
  
  def mending
    @mending = @dealer.mending || Tips::Mending.create(dealer: @dealer)
    @types = Tips::MendingOrderDetail::MendingType.all
  end

  def cleaning
    @cleanings = @dealer.cleanings
  end
  
end
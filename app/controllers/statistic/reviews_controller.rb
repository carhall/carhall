class Statistic::ReviewsController < Statistic::ApplicationController
  authorize_resource class: Tips::Review
  before_filter :set_dealer

  helper StatisticsHelper
  
  def mending
    @mending = @dealer.mending || @dealer.create_mending
  end

  def cleaning
    @cleanings = @dealer.cleanings
  end
  
end
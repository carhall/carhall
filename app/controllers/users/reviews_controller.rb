class Users::ReviewsController < ApplicationController
  prepend_before_filter :ensure_user_type
  before_filter :set_dealer

  helper StatisticsHelper

  def cleaning
    @cleanings = @dealer.cleanings
  end
  
  def mending
    @mending = @dealer.mending || Mending.create(dealer: @dealer)
    @types = Tips::MendingOrderDetail::MendingType.all
  end
end
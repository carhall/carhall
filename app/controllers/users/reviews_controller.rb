class Users::ReviewsController < ApplicationController
  prepend_before_filter :ensure_user_type
  before_filter :set_dealer

  def cleaning
    @cleanings = @dealer.cleanings
  end
  
  def mending
    @mending = @dealer.mending
    @orders = @mending.orders
    @types = Tips::MendingOrderDetail::MendingTypes
  end
end
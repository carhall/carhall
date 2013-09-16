class Users::ReviewsController < ApplicationController
  prepend_before_filter :ensure_user_type
  before_filter :set_dealer

  def cleaning
    @cleanings = @dealer.cleanings
  end
  
  def mending
    @mending = @dealer.mending
    @types = Tips::MendingOrderDetail::MendingTypes
    @grouped_orders = @mending.orders_group_by_brand_and_type
    @grouped_reviews = @mending.reviews_group_by_brand_and_type
  end
end
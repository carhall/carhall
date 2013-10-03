class Api::Tips::BulkPurchasingsController < Api::Tips::ApplicationController
  set_resource_class ::Tips::BulkPurchasing

  def set_filter
    super
    filter_parent :bulk_purchasing_type
  end

  def set_parent
    @parent = ::Tips::BulkPurchasing.includes(:dealer, :reviews)
    @parent = @parent.with_dealer @dealer if @dealer
    @parent = @parent.in_progress
  end

end

class Api::Tips::BulkPurchasingsController < Api::Tips::ApplicationController
  set_resource_class BulkPurchasing
  before_filter :set_filter

  def set_filter
    @parent = @parent.where(params[:filter].slice(:bulk_purchasing_type_id)) if params[:filter]
  end

end

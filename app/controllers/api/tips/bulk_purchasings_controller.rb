class Api::Tips::BulkPurchasingsController < Api::Tips::ApplicationController
  set_resource_class Tips::BulkPurchasing
  before_filter :set_filter

  def set_filter
    @parent = @parent.with_bulk_purchasing_type(params[:filter][:bulk_purchasing_type_id].to_i) if params[:filter]
  end

end

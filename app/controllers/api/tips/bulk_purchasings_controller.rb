class Api::Tips::BulkPurchasingsController < Api::Tips::ApplicationController
  set_resource_class ::Tips::BulkPurchasing

  def set_filter
    super
    if params[:filter] and params[:filter][:bulk_purchasing_type_id]
      @parent = @parent.with_bulk_purchasing_type(params[:filter][:bulk_purchasing_type_id].to_i)
    end
  end

end

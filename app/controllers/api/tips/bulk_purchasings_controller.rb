class Api::Tips::BulkPurchasingsController < Api::Tips::ApplicationController
  set_resource_class ::Tips::BulkPurchasing

  def set_filter
    super
    filter_parent :bulk_purchasing_type
  end

end

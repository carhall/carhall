class Api::Tips::BulkPurchasingsController < Api::Tips::ApplicationController
  skip_before_filter :authenticate_account_from_token!, only: [:index]
  set_resource_class ::Tips::BulkPurchasing

  def set_filter
    super
    filter_parent :bulk_purchasing_type
  end

end

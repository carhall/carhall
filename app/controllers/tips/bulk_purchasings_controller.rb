class Tips::BulkPurchasingsController < Tips::ApplicationController
  set_resource_class BulkPurchasing, orders: true

end

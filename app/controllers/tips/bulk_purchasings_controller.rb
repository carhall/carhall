class Tips::BulkPurchasingsController < Tips::ApplicationController
  set_resource_class ::Tips::BulkPurchasing, orders: true, expiredable: true

end

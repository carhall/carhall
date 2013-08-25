class BulkPurchasingOrder < BaseOrder
  set_detail_class Tips::BulkPurchasingOrderInfo

  belongs_to :source, class_name: 'BulkPurchasing', counter_cache: true

end

class BulkPurchasingOrder < BaseOrder
  set_detail_class Tips::BulkPurchasingOrderDetail

  belongs_to :source, class_name: 'BulkPurchasing', counter_cache: true

end

class BulkPurchasingOrder < Order
  set_detail_class Tips::BulkPurchasingOrderDetail
  belongs_to :source, class_name: BulkPurchasing, counter_cache: :orders_count

end

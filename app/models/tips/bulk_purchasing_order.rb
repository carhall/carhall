class Tips::BulkPurchasingOrder < Tips::Order
  set_detail_class Tips::BulkPurchasingOrderDetail
  belongs_to :source, class_name: Tips::BulkPurchasing, counter_cache: :orders_count

end

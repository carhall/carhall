class MendingOrder < BaseOrder
  set_detail_class Tips::MendingOrderInfo

  belongs_to :source, class_name: 'Mending', counter_cache: true

end

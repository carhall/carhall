class Tips::BulkPurchasingOrder < Tips::Order
  belongs_to :source, class_name: 'BulkPurchasing', counter_cache: :orders_count

  validates_presence_of :count

  api_accessible :detail, extend: :base do |t|
    t.add :count
  end
  
end

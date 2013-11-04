class Tips::BulkPurchasingOrder < Tips::Order
  belongs_to :source, class_name: 'BulkPurchasing', counter_cache: :orders_count

  validates_presence_of :count
  
  def to_base_builder
    json = super
    json.extract! self, :count
    json
  end

end

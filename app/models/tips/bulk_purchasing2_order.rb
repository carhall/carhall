class Tips::BulkPurchasing2Order < ActiveRecord::Base
  belongs_to :source, class_name: 'BulkPurchasing2', counter_cache: :orders_count

  validates_presence_of :count
  
end

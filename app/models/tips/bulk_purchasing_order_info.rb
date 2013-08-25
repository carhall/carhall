module Tips
  class BulkPurchasingOrderInfo < ActiveRecord::Base
    belongs_to :source, class_name: 'BulkPurchasingOrder'
    alias_attribute :bulk_purchasing_order, :source
    alias_attribute :order, :source

    attr_accessible :source
    attr_accessible :count

    def serializable_hash(options={})
      options = { 
        only: [:price, :count],
      }.update(options)
      super(options)
    end

  end
end
module Tips
  class BulkPurchasingOrderDetail < ActiveRecord::Base
    attr_accessible :count

    def serializable_hash(options={})
      options = { 
        only: [:price, :count],
      }.update(options)
      super(options)
    end

  end
end
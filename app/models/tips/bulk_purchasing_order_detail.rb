class Tips::BulkPurchasingOrderDetail < ActiveRecord::Base
  attr_accessible :count

  validates_presence_of :count

  def serializable_hash(options={})
    options = { 
      only: [:price, :count],
    }.update(options)
    super(options)
  end

end

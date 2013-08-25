module Tips
  class CleaningOrderInfo < ActiveRecord::Base
    belongs_to :source, class_name: 'CleaningOrder'
    alias_attribute :cleaning_order, :source
    alias_attribute :order, :source

    attr_accessible :source
    attr_accessible :count, :used_count

    def serializable_hash(options={})
      options = { 
        only: [:price, :count, :used_count],
      }.update(options)
      super(options)
    end

  end
end
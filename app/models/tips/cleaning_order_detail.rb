module Tips
  class CleaningOrderDetail < ActiveRecord::Base
    attr_accessible :count

    validates_presence_of :count

    def serializable_hash(options={})
      options = { 
        only: [:price, :count, :used_count],
      }.update(options)
      super(options)
    end

  end
end
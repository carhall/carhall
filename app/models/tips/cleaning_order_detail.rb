module Tips
  class CleaningOrderDetail < ActiveRecord::Base
    attr_accessible :count, :used_count

    def serializable_hash(options={})
      options = { 
        only: [:price, :count, :used_count],
      }.update(options)
      super(options)
    end

  end
end
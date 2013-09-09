module Tips
  class MendingOrderDetail < ActiveRecord::Base
    include Share::Brandable

    attr_accessible :brand_id, :brand,
      :plate_num, :arrive_at, :mending_type

    def serializable_hash(options={})
      options = { 
        only: [:price, :plate_num, :arrive_at, :mending_type],
        methods: [:brand]
      }.update(options)
      super(options)
    end

  end
end
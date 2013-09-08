module Tips
  class MendingOrderInfo < ActiveRecord::Base
    include Share::Brandable

    # belongs_to :source, class_name: 'MendingOrder'
    # alias_attribute :mending_order, :source
    # alias_attribute :order, :source

    # attr_accessible :source
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
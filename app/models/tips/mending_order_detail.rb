module Tips
  class MendingOrderDetail < ActiveRecord::Base
    include Share::Brandable

    attr_accessible :brand_id, :brand, :series,
      :plate_num, :arrive_at, :description

    validates_presence_of :brand_id, :series, :plate_num, :arrive_at

    def serializable_hash(options={})
      options = { 
        only: [:brand_id, :series, :price, :plate_num, :arrive_at, :description],
        methods: [:brand]
      }.update(options)
      super(options)
    end

  end
end
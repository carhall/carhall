class Tips::MendingOrderDetail < ActiveRecord::Base
  enumerate :brand, with: Share::Brand

  attr_accessible :brand_id, :brand, :series, :plate_num, :arrive_at, 
    :description, :mending_type_id, :mending_type

  validates_presence_of :brand_id, :series, :plate_num, :arrive_at, :mending_type_id

  enumerate :mending_type, with: %w(标准保养 维修)

  def serializable_hash(options={})
    options = { 
      only: [:brand_id, :series, :plate_num, :arrive_at, :mending_type_id, :description],
      methods: [:brand, :mending_type]
    }.update(options)
    super(options)
  end

end

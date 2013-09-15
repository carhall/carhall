class Tips::MendingOrderDetail < ActiveRecord::Base
  include Share::Brandable

  attr_accessible :brand_id, :brand, :series,
    :plate_num, :arrive_at, :description

  validates_presence_of :brand_id, :series, :plate_num, :arrive_at

  extend Share::Id2Key
  MendingTypes = %w(标准保养 维修)
  define_id2key_methods :mending_type

  def serializable_hash(options={})
    options = { 
      only: [:brand_id, :series, :price, :plate_num, :arrive_at, :mending_type_id, :description],
      methods: [:brand, :mending_type]
    }.update(options)
    super(options)
  end

end

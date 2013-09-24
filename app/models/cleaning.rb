class Cleaning < ActiveRecord::Base
  include Share::Servicable
  set_order_class CleaningOrder

  extend Share::ImageAttachments
  define_image_method
  
  include Share::Localizable
  include Share::Statisticable
  
  attr_accessible :title, :cleaning_type_id, :price, :vip_price, :description, :image

  validates_presence_of :dealer
  validates_presence_of :title, :cleaning_type_id, :price, :vip_price

  extend Share::Id2Key
  CleaningTypes = %w(洗车 漆面养护 清洁护理)
  define_id2key_methods :cleaning_type

  def serializable_hash(options={})
    options = { 
      only: [:id, :title, :cleaning_type_id, :price, :vip_price, :description, 
        :orders_count, :reviews_count],
      methods: [:cleaning_type, :stars],
      images: [:image],
      include: [:dealer],
    }.update(options)
    super(options)
  end

end

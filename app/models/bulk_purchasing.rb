class BulkPurchasing < ActiveRecord::Base
  include Share::Servicable
  set_order_class BulkPurchasingOrder
  
  extend Share::ImageAttachments
  define_image_method

  include Share::Localizable
  include Share::Statisticable
  
  attr_accessible :title, :bulk_purchasing_type_id, :expire_at, :price, :vip_price, :description, :image

  validates_presence_of :dealer
  validates_presence_of :title, :bulk_purchasing_type_id, :expire_at, :price, :vip_price

  extend Share::Id2Key
  BulkPurchasingTypes = %w(洗车美容 保养专修 汽车装饰 其他)
  define_id2key_methods :bulk_purchasing_type

  include Share::Expiredable

  def serializable_hash(options={})
    options = { 
      only: [:id, :title, :expire_at, :bulk_purchasing_type_id, 
        :price, :vip_price, :description, :orders_count],
      methods: [:bulk_purchasing_type],
      images: [:image],
      include: [:dealer],
    }.update(options)
    super(options)
  end
  
end

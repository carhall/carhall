class Tips::BulkPurchasing < ActiveRecord::Base
  include Tips::Servicable
  set_order_class Tips::BulkPurchasingOrder
  
  extend Share::ImageAttachments
  define_image2_method

  include Share::Statisticable
  
  validates_presence_of :dealer
  validates_presence_of :title, :bulk_purchasing_type_id, :expire_at, :price, :vip_price

  enumerate :bulk_purchasing_type, with: %w(洗车美容 保养维修 汽车装饰 汽车销售)
  
  include Tips::Expiredable
  scope :ordered, -> { displayed.positioned.in_progress }

  def to_base_builder
    Jbuilder.new do |json|
      json.extract! self, :id, :title, :expire_at, :area_id, :area,
        :bulk_purchasing_type_id, :bulk_purchasing_type, :price, :vip_price, 
        :description, :orders_count, :reviews_count, :stars
      json.image! self, :image
    end
  end
  
  to_detail_builder
  
end

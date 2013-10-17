class Tips::BulkPurchasing < ActiveRecord::Base
  include Tips::Servicable
  set_order_class Tips::BulkPurchasingOrder
  
  extend Share::ImageAttachments
  define_image_method

  enumerate :area, with: Share::Area
  
  include Share::Localizable
  include Share::Statisticable
  
  validates_presence_of :dealer
  validates_presence_of :title, :bulk_purchasing_type_id, :expire_at, :price, :vip_price

  enumerate :bulk_purchasing_type, with: %w(洗车美容 保养专修 汽车装饰 其他)

  include Tips::Expiredable
  scope :ordered, -> { displayed.positioned.in_progress }

  api_accessible :base, includes: [:dealer] do |t|
    t.only :id, :title, :expire_at, :area_id, :bulk_purchasing_type_id, :price, :vip_price, 
        :description, :orders_count, :reviews_count
    t.methods :area, :bulk_purchasing_type, :stars
    t.images :image
    t.add :dealer, template: :base
  end
  
  api_accessible_for_detail
  
end

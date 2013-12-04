class Tips::BulkPurchasing2 < ActiveRecord::Base
  include Share::Distributorable
  include Share::Dealerable

  default_scope { order('id DESC') }
  
  include Share::Areable
  include Share::Localizable
  
  before_save do
    self.area_id = distributor.area_id
    self.location_id = distributor.location_id
  end

  has_many :orders, class_name: Tips::BulkPurchasing2Order, foreign_key: :source_id
  has_many :recent_orders, -> { where "orders.created_at > ?", 1.month.ago }, 
    class_name: Tips::BulkPurchasing2Order, foreign_key: :source_id
  
  extend Share::ImageAttachments
  define_image_method

  validates_presence_of :distributor
  validates_presence_of :title, :bulk_purchasing_type_id, :expire_at, :price, :vip_price, :inventory

  enumerate :bulk_purchasing_type, with: %w(汽车用品 洗车美容工具 汽保工具 美容养护 深化养护 汽车配件 电子产品)

  include Tips::Expiredable

end

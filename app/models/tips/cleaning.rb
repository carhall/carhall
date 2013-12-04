class Tips::Cleaning < ActiveRecord::Base
  include Tips::Servicable
  set_order_class Tips::CleaningOrder

  extend Share::ImageAttachments
  define_image2_method
  
  include Share::Statisticable

  enumerate :cleaning_type, with: %w(洗车 漆面养护 清洁护理 轮胎 换油 改装 钣喷)
  
  validates_presence_of :dealer
  validates_presence_of :title, :cleaning_type_id, :price, :vip_price

  def to_base_builder
    Jbuilder.new do |json|
      json.extract! self, :id, :title, :area_id, :area,
        :cleaning_type_id, :cleaning_type, :price, :vip_price, 
        :description, :orders_count, :reviews_count, :stars
      json.image! self, :image
    end
  end
  
  to_detail_builder
  
end

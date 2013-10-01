class Tips::Cleaning < ActiveRecord::Base
  include Tips::Servicable
  set_order_class Tips::CleaningOrder

  extend Share::ImageAttachments
  define_image_method
  
  enumerate :area, with: Share::Area
  enumerate :cleaning_type, with: %w(洗车 漆面养护 清洁护理)
  
  validates_presence_of :dealer
  validates_presence_of :title, :cleaning_type_id, :price, :vip_price
  
  include Share::Localizable
  include Share::Statisticable

  api_accessible :base do |t|
    t.only :id, :title, :cleaning_type_id, :price, :vip_price, :description, 
        :orders_count, :reviews_count
    t.methods :cleaning_type, :stars
    t.images :image
    t.add :dealer, template: :base
  end
  
end

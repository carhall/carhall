class Cleaning < ActiveRecord::Base
  include Tips::Servicable
  set_order_class CleaningOrder

  extend Share::ImageAttachments
  define_image_method
  
  enumerate :area, with: Share::Area
  include Share::Localizable
  include Share::Statisticable
  
  validates_presence_of :dealer
  validates_presence_of :title, :cleaning_type_id, :price, :vip_price

  enumerate :cleaning_type, with: %w(洗车 漆面养护 清洁护理)

  api_accessible :base do |t|
    t.only :id, :title, :cleaning_type_id, :price, :vip_price, :description, 
        :orders_count, :reviews_count
    t.methods :cleaning_type, :stars
    t.images :image
    t.add :dealer, template: :base
  end
  
end

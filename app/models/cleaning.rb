class Cleaning < ActiveRecord::Base
  include Share::Servicable
  set_order_class CleaningOrder

  extend Share::ImageAttachments
  define_image_method
  
  include Share::Areable
  include Share::Localizable
  include Share::Statisticable
  
  attr_accessible :title, :cleaning_type_id, :price, :vip_price, :description, :image

  validates_presence_of :dealer
  validates_presence_of :title, :cleaning_type_id, :price, :vip_price

  extend Share::Id2Key
  CleaningTypes = %w(洗车 漆面养护 清洁护理)
  define_id2key_methods :cleaning_type

  acts_as_api

  api_accessible :base do |t|
    t.only :id, :title, :cleaning_type_id, :price, :vip_price, :description, 
        :orders_count, :reviews_count
    t.methods :cleaning_type, :stars
    t.images :image
    t.add :dealer, template: :base
  end
  
end

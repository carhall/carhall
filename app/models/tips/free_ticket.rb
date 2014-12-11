class Tips::FreeTicket < ActiveRecord::Base
 include Tips::Servicable
  set_order_class Tips::FreeTicketOrder
  #default_scope { where(is_cheyouhui: false) }

  extend Share::ImageAttachments
  define_image2_method
  
  include Share::Statisticable

  include Tips::Expiredable

  enumerate :ticket_type, with: %w(5座轿车 7座轿车 SUV)
  
  validates_presence_of :dealer
  validates_presence_of :title, :ticket_type_id, :price, :vip_price

  def to_base_builder
    Jbuilder.new do |json|
      json.extract! self, :id, :title, :area_id, :area,
        :cleaning_type_id, :ticket_type, :price, :vip_price, 
        :description, :orders_count, :reviews_count, :stars
      json.image! self, :image
    end
  end
  
  to_detail_builder
  
end

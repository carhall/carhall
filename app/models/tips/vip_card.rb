class Tips::VipCard < ActiveRecord::Base
  include Tips::Servicable
  set_order_class Tips::VipCardOrder

  extend Share::ImageAttachments
  define_image2_method

  include Share::Statisticable

  has_many :vip_card_items, class_name: 'Tips::VipCardItem'
  accepts_nested_attributes_for :vip_card_items, allow_destroy: true
  alias_attribute :items, :vip_card_items

  validates_presence_of :title, :vip_price

  def status
    displayed? ? '已启用' : '已弃用'
  end

  def to_base_builder
    Jbuilder.new do |json|
      json.extract! self, :id, :title, :area_id, :area, 
        :price, :vip_price, :description, 
        :orders_count, :reviews_count, :stars
      json.image! self, :image
    end
  end

  def to_detail_builder
    json = to_base_builder
    json.items(items.map{|i|i.to_base_builder.attributes!})
    json.detail do
      json.extract! self, :goal_attainment
      json.last_3_orders(orders.includes(:user).reorder('id DESC').first(3).map{|o|o.to_base_builder.attributes!})
      json.last_3_reviews(reviews.includes(order:[:user]).first(3).map{|o|o.to_base_builder.attributes!})
    end
    json.builder! self, :dealer, :detail_without_statistic
    json
  end

end

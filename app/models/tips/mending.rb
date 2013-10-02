class Tips::Mending < ActiveRecord::Base
  include Tips::Servicable
  set_order_class Tips::MendingOrder
  
  serialize :discount, Hash

  serialize :total_sales, Hash

  serialize :orders_counts, Hash
  serialize :reviews_counts, Hash
  serialize :stars_counts, Hash

  serialize :brand_ids, Array
  enumerate :brands, with: Share::Brand, multiple: true

  def self.with_brand name
    id = active_enum_get_id_for_brands(name)
    where('brand_ids LIKE \'%- ?\n%\'', id)
  end

  enumerate :area, with: Share::Area

  validates_presence_of :dealer
  validates_length_of :brand_ids, :maximum => 5
  
  include Share::Localizable
  include Share::Statisticable

  api_accessible :base do |t|
    t.only :id, :area_id, :brand_ids, :description, :orders_count, :reviews_count
    t.methods :area, :brands, :discount, :stars
    t.add :dealer, template: :base
  end
  
  api_accessible_for_detail

  def init_grouped_array_by_brand_and_type
    brands_count = Share::Brand.all.count
    types_count = Tips::MendingOrderDetail::MendingType.all.count
    Array.new(brands_count+1) { Array.new(types_count+1) { [] }}
  end

  def orders_group_by_brand_and_type
    orders = self.orders.includes(:detail)
    grouped_orders = init_grouped_array_by_brand_and_type
    orders.each do |order|
      grouped_orders[order.detail.brand_id][order.detail.mending_type_id] << order
    end
    grouped_orders
  end

  def reviews_group_by_brand_and_type
    reviews = self.reviews.includes(order: :detail)
    grouped_reviews = init_grouped_array_by_brand_and_type
    reviews.each do |review|
      grouped_reviews[review.order.detail.brand_id][review.order.detail.mending_type_id] << review
    end
    grouped_reviews
  end

end
class Mending < ActiveRecord::Base
  include Share::Servicable
  set_order_class MendingOrder
  
  serialize :discount, Hash

  validates_presence_of :dealer

  serialize :total_sales, Hash

  serialize :orders_counts, Hash
  serialize :reviews_counts, Hash
  serialize :stars_counts, Hash

  extend Share::Id2Key
  Brands = Share::Brandable::Brands
  define_ids2keys_methods :brands

  include Share::Areable
  include Share::Localizable
  include Share::Statisticable

  attr_accessible :dealer
  attr_accessible :discount, :brand_ids
  attr_accessible :brands

  acts_as_api

  api_accessible :base do |t|
    t.only :id, :brand_ids, :description, :orders_count, :reviews_count
    t.methods :brands, :discount
    t.add :dealer, template: :base
  end
  
  def init_grouped_array_by_brand_and_type
    brands_count = Share::Brandable::Brands.count
    types_count = Tips::MendingOrderDetail::MendingTypes.count
    Array.new(brands_count) { Array.new(types_count) { [] }}
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
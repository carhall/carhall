class Mending < ActiveRecord::Base
  belongs_to :dealer
  has_many :mending_orders, foreign_key: :source_id
  alias_attribute :orders, :mending_orders

  has_many :reviews, through: :mending_orders

  serialize :discount, Hash

  validates_presence_of :dealer

  extend Share::Id2Key
  Brands = Share::Brandable::Brands
  define_ids2keys_methods :brands

  include Share::Localizable

  attr_accessible :dealer
  attr_accessible :discount, :brand_ids
  attr_accessible :brands

  def serializable_hash(options={})
    options = { 
      only: [:id, :brand_ids, :description, :orders_count],
      methods: [:brands, :discount],
      include: [:dealer],
    }.update(options)
    super(options)
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
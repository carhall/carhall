class Tips::Mending < ActiveRecord::Base
  include Tips::Servicable
  set_order_class Tips::MendingOrder
  
  serialize :discount, Hash

  serialize :total_sales, Hash

  serialize :orders_counts, Hash
  serialize :reviews_counts, Hash
  serialize :stars_counts, Hash

  serialize :brand_ids, Array
  enumerate :brands, with: Category::Brand, multiple: true

  scope :with_brand, -> (name) {
    id = active_enum_get_id_for_brands(name)
    where('brand_ids LIKE \'%- ?\n%\'', id)
  }

  enumerate :area, with: Category::Area

  validates_presence_of :dealer
  validates_length_of :brand_ids, :maximum => 5, :message => I18n.t(".to_many")
  
  include Share::Localizable
  include Share::Statisticable

  def to_without_dealer_builder
    Jbuilder.new do |json|
      json.extract! self, :id, :area_id, :area, :brand_ids, :brands, 
        :description, :orders_count, :reviews_count, :discount, :stars
    end
  end

  def to_base_builder
    json = to_without_dealer_builder
    json.builder! self, :dealer, :base
    json
  end

  to_detail_builder

  def init_grouped_array_by_brand_and_type
    brands_count = Category::Brand.all.count
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
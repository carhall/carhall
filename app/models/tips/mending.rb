class Tips::Mending < ActiveRecord::Base
  include Tips::Servicable
  set_order_class Tips::MendingOrder
  
  include Share::Statisticable
  
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

  validates_presence_of :dealer
  validates_length_of :brand_ids, :maximum => 5, :message => I18n.t(".to_many")
  
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

  def orders_group_by_brand_and_type
    hash = orders.includes(:detail).group_by do |order|
      order.detail.brand_id
    end
    hash.update hash do |key, value|
      value.group_by do |order|
        order.detail.mending_type_id
      end
    end
  end

  def reviews_group_by_brand_and_type
    hash = reviews.includes(order: :detail).group_by do |review|
      review.order.detail.brand_id
    end
    hash.update hash do |key, value|
      value.group_by do |review|
        review.order.detail.mending_type_id
      end
    end
  end

end
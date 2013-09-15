class MendingOrder < Order
  set_detail_class Tips::MendingOrderDetail
  belongs_to :source, class_name: Mending, counter_cache: :orders_count

  def set_title
    I18n.t(".mending", dealer: dealer.username, brand: detail.brand)
  end

  def set_cost
    0
  end

  def self.with_brand brand
    brand_id = Share::Brandable.get_id brand
    joins(:detail).where("mending_order_details.brand_id == ?", brand_id)
  end

  def self.with_type type
    type_id = if type.is_a? Integer then type else Tips::MendingOrderDetail::MendingTypes.index type end
    joins(:detail).where("mending_order_details.mending_type_id == ?", type_id)
  end

end

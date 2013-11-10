class Tips::MendingOrder < Tips::Order
  set_detail_class Tips::MendingOrderDetail
  belongs_to :source, class_name: 'Mending', counter_cache: :orders_count

  validates_presence_of :detail

  def set_title
    I18n.t(".mending", dealer: dealer.username, brand: detail.brand)
  end

  def set_cost
    0
  end

  def to_base_builder
    json = super
    json.builder! self, :detail, :base
    json
  end
  
  def use count
    finish
  end

  def used?
    finished?
  end
  
end

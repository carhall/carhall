class Tips::MendingOrder < Tips::Order
  set_detail_class Tips::MendingOrderDetail
  delegate :brand, :mending_type, to: :detail, allow_nil: true
  
  belongs_to :source, class_name: 'Mending', counter_cache: :orders_count

  validates_presence_of :detail

  def set_title
    I18n.t(".mending", dealer: dealer.username, brand: detail.brand)
  end

  def set_cost; 0; end

  def to_base_builder
    json = super
    json.builder! self, :detail, :base
    json
  end
  
  def use(count); finish; end
  def used?; finished?; end
  
  after_initialize do |order|
    if user = order.user
      order.brand_id ||= user.brand_id
      order.series ||= user.series
      order.plate_num ||= user.plate_num
    end
  end

end

class MendingOrder < Order
  set_detail_class Tips::MendingOrderDetail
  belongs_to :source, class_name: 'Mending', counter_cache: :orders_count

  def set_title
    I18n.t(".mending", dealer: dealer.username, brand: detail.brand)
  end

  def set_cost
    0
  end

  api_accessible :detail, extend: :base do |t|
    t.add :detail, template: :base
  end
  
end

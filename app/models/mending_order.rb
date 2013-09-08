class MendingOrder < BaseOrder
  set_detail_class Tips::MendingOrderDetail

  belongs_to :source, class_name: 'Mending', counter_cache: true

  def set_title
    I18n.t(".mending", brand: detail.brand)
  end
end

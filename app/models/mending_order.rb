class MendingOrder < BaseOrder
  set_detail_class Tips::MendingOrderDetail

  def set_title
    I18n.t(".mending", brand: detail.brand)
  end
end

class Tips::SecondhandAppraiseOrder < Tips::Order
  set_detail_class Tips::SecondhandAppraiseOrderDetail
  delegate :brand, to: :detail, allow_nil: true

  validates_presence_of :detail, :dealer

  def set_title
    I18n.t(".secondhand_appraise", dealer: dealer.username, brand: detail.brand)
  end

  def set_cost; 0; end
  def source; true; end
  def use(count); finish; end
  def used?; finished?; end
  
end
